//
//  World.m
//  DescentEditor
//
//  Created by Milan Toth on 11/13/11.
//  Copyright (c) 2011 The MilGra Experience. All rights reserved.
//

#import "Physics.h"

#define DEPSILON 1.0E-10

@implementation Physics


    @synthesize walls;
    @synthesize masses;


    - ( id ) init
    {

        self = [ super init ];
        
        if ( self )
        {
                            
            gravity = VectorInit( 0 , 1 );

            walls   = ChainInit( );
            masses  = ChainInit( );
            spacers = ChainInit( );
        
        }
        
        return self;

    }
    
    
    - ( void ) dealloc
    {
    
        ChainDestruct( walls );
        ChainDestruct( masses );
        ChainDestruct( spacers );
    
        [ super dealloc ];
    
    }
    
    
    - ( void ) addSpacer : ( struct Spacer* ) aSpacer
    {

        ChainAdd( spacers , ( void* ) aSpacer );
    
    }
    
    
    - ( void ) addMassPoint : ( struct Mass* ) aMass
    {

        ChainAdd( masses , ( void* ) aMass );
    
    }
    
    
    - ( void ) addWallSegment : ( struct Segment* ) aSegment
    {
    
        ChainAdd( walls , ( void* ) aSegment );
    
    }


//
//    SIMULATION STEP
//    
//    1. gravitacio hozzaadasa
//    2. tavtartok jovendo vegpont alapjan hozzaadjak a modosito eroket
//        - ha valamelyik mass SLIDING modban van, akkor az az oldal nem nyomodhat
//    3. ha a tomegpont SLIDING modban van, fallal parhuzamos eredot kiszamolni, ha az kilog, akkor utkozest nezni
//    4. ha a tomegpont BOUNCING modban van, akkor utkozeseket vizsgalni a feluletekkel	- iterativ modon, az uj komponenset is le kell ellenorizni az eronek
//        - ha az utolso mar nem utkozik, akkor utolso utkozesi pontba mozgatni tomegpontot, es ujraszamolni az eredot
//        - ha az eredo hatarertek ala esik, tomegpontot SLIDING modba rakni
//        - ha ket fallal is utkozik, akkor  a meroleges komponensek osszege az uj iranyvektor
//    5. leptetes : poziciohoz hozzaadni az eredo erot
    
    - ( void ) step
    {
            
        // calculate forces
        
        //
        //  1. Gravity step
        //
        
        struct Chain* link = masses;
        
        while ( link != NULL )
        {
        
            VectorAddTo( ( ( struct Mass* ) link->value )->originalForce , gravity );
            link = link->next;
            
        }
        
        //
        //  2. Resolver step
        //
        
        link = spacers;
        
        while ( link != NULL && spacers->length > 0 ) 
        {

            SpacerRespace( ( struct Spacer* ) link->value );
            link = link->next;
  
        }
        
        //
        //  3. Sliding step
        //        
        
        link = masses;
        
        while ( link != NULL )
        {
                
            struct Mass* massPoint = ( struct Mass* ) link->value;
            
            if ( massPoint->baseWallA != NULL )
            {
            
                if ( massPoint->baseWallB == NULL )
                {
                
                    // TODO if oroginal force directs away from wall, then switch to bouncing mode ( for ex. falling from ceiling )
            
                    // calculating perpenducilar and parallel forces
                
                    struct Vector* wallVector = VectorInit( massPoint->baseWallA->cornerB->x - massPoint->baseWallA->cornerA->x , 
                                                            massPoint->baseWallA->cornerB->y - massPoint->baseWallA->cornerA->y );

                    double paraLength = cos( massPoint->originalForce->angle - wallVector->angle ) * massPoint->originalForce->length;
                    
                    struct Vector* paraForce = VectorInit( cos( wallVector->angle ) * paraLength , 
                                                           sin( wallVector->angle ) * paraLength );
                                                           
                    // set original force to parallel force
                                       
                    VectorSet( massPoint->originalForce , paraForce->x , paraForce->y );
                    VectorMultiply( massPoint->originalForce , massPoint->friction );
                    
                    // prepare mass point for bouncing, to exclude touched wall
                                            
                    massPoint->lastTouchedWallA = massPoint->baseWallA;
                
                }
                else VectorSet( massPoint->originalForce , 0 , 0 );

            }
            
            link = link->next;
            
        }
        
        //
        //  4. Bouncing step
        //

        link = masses;
        
        while ( link != NULL )
        {
                
            struct Mass* massPoint = ( struct Mass* ) link->value;
                
            // setting partial force and position to make iteration possible with partials
            
            VectorSet( massPoint->partialForce    , massPoint->originalForce->x    , massPoint->originalForce->y );
            VectorSet( massPoint->partialPosition , massPoint->originalPosition->x , massPoint->originalPosition->y );
                       
            //
            //  BOUNCING STEP
            //
            //  if a masspoint collides with a wall, moving particle to the endpoint of bounced movement vector
            //  iteration until no collosion is needed if a particle is in the corner of an acute angle
            //
            
            while ( [ self bounceMass : massPoint ] ) { }

            if ( massPoint->hadCollosion == 1 )
            {
            
                if ( massPoint->baseWallA == NULL )
                {
                
                    // if collosion happened, masspoint contains the last partial force
                    // we use it as the direction vector of the original force
                    // but we have to resize it to the originalvector's size

                    VectorAddTo(    massPoint->partialPosition  , massPoint->partialForce );
                    VectorMultiply( massPoint->partialForce     , massPoint->originalForce->length / massPoint->partialForce->length );
                    
                    VectorSet(      massPoint->originalPosition , massPoint->partialPosition->x , massPoint->partialPosition->y );
                    VectorSet(      massPoint->originalForce    , massPoint->partialForce->x    , massPoint->partialForce->y );

                    VectorMultiply( massPoint->originalForce    , massPoint->buoyancy );

                    // if bounce is too small, set mass to sliding mode
                                    
                    if ( massPoint->originalForce->length < 1 )
                    {
                    
                        if ( massPoint->baseWallA == NULL ) massPoint->baseWallA = massPoint->lastWallA;
                        else massPoint->baseWallB = massPoint->lastWallA;
    
                    }
                
                }
                else
                {                

                    if ( massPoint->originalForce->length < 1 )
                    {
                    
                        // if collosion is smaller, set bouncing wall as the second wall
                    
                        massPoint->baseWallB = massPoint->lastWallB == NULL ? massPoint->lastWallA : massPoint->lastWallB;
                    
                    }
                    else
                    {
                    
                        // if collosion bigger than border level, put mass to bouncing mode
                        
                        massPoint->baseWallA = NULL;
                        massPoint->baseWallB = NULL;
                    
                    }
                    
                }
                
            }
            
            // step to next masspoint
            
            link = link->next;
        
        }        
        
        //
        //  MOVEMENT STEP
        //
        //  if no collosion happened to a masspoint, moving it freely
        //
        
        link = masses;
        
        while ( link != NULL )
        {

            struct Mass* massPoint = ( struct Mass* ) link->value;
            
            if ( massPoint->hadCollosion == 0 ) VectorAddTo( massPoint->originalPosition , massPoint->originalForce );
            
            massPoint->hadCollosion = 0;

            link = link->next;
        
        }
        
    }
    
    // check collosion with walls
    // if collosion happens, move partial position to collosion point, 
    // set partial force to the remaining size of original force
    // if particle collides with the endpoints of two segments, partial force direction
    // is the bisector of the two segments
    //
    // Ax + By = C       
    // A = y2-y1
    // B = x1-x2
    // C = A*x1+B*y1
    
    - ( BOOL ) bounceMass : ( struct Mass* ) aMass
    {
        
        struct Vector* force = aMass->partialForce;
        struct Vector* start = aMass->partialPosition;
        
        BOOL hasCollosion = NO;
        
        struct Vector* lastPivot    = VectorInit( 0 , 0 );
        struct Vector* lastNormal   = VectorInit( 0 , 0 );
        struct Vector* lastParallel = VectorInit( 0 , 0 );
        
        struct Segment* hittingA = NULL;
        struct Segment* hittingB = NULL;
        
        //  Preparing line parameters of force
        
        double forceA =  force->y;
        double forceB = -force->x;
        double forceC = forceA * start->x + forceB * start->y;
        
        struct Chain* link = walls;
        
        while ( link != NULL )
        {
            
            struct Segment*  wall = ( struct Segment* ) link->value;

            if ( aMass->lastTouchedWallA != wall && 
                 aMass->lastTouchedWallB != wall )
            {
            
                //  Preparing line parameters of wall

                struct Vector*  cornerA = wall->cornerA;
                struct Vector*  cornerB = wall->cornerB;
            
                double wallA = cornerB->y - cornerA->y;
                double wallB = cornerA->x - cornerB->x;
                double wallC = wallA * cornerA->x + wallB * cornerA->y;
                
                double determ = forceA * wallB - wallA * forceB;
                
                if ( determ != 0 )
                {
                
                    double hitX = ( wallB * forceC - forceB * wallC ) / determ;
                    double hitY = ( forceA * wallC - wallA * forceC ) / determ;
                    
                    // if particle is on wall, waiting for next step to collide
                    
                    if ( ! (  ( fabs( hitX - ( start->x + force->x ) ) < DEPSILON ) && 
                              ( fabs( hitY - ( start->y + force->y ) ) < DEPSILON ) ) )
                    { 
                                        
                        // if interval is ok
                                                                
                        if (    fmin( cornerA->x , cornerB->x ) < hitX + DEPSILON &&
                                fmax( cornerA->x , cornerB->x ) > hitX - DEPSILON &&
                                fmin( cornerA->y , cornerB->y ) < hitY + DEPSILON &&
                                fmax( cornerA->y , cornerB->y ) > hitY - DEPSILON &&
                                fmin( start->x  , start->x + force->x ) < hitX + DEPSILON &&
                                fmax( start->x  , start->x + force->x ) > hitX - DEPSILON &&
                                fmin( start->y  , start->y + force->y ) < hitY + DEPSILON &&
                                fmax( start->y  , start->y + force->y ) > hitY - DEPSILON )
                        {
                        
                            // TODO maybe no normal/parallel calculation is needed, a simple forceEnding-rotation is enough
                            
                            hasCollosion = YES;

                            // calculating normal and parallel forces
                        
                            struct Vector* wallVector = VectorInit( cornerB->x - cornerA->x , 
                                                                    cornerB->y - cornerA->y );

                            struct Vector* forceEnding = VectorInit( start->x + force->x - hitX ,
                                                                     start->y + force->y - hitY );
                                                                     
                            double normLength = sin( force->angle - wallVector->angle ) * force->length;
                            double paraLength = cos( force->angle - wallVector->angle ) * force->length;
                            
                            struct Vector* normForce = VectorInit( sin( wallVector->angle ) * normLength , 
                                                                   cos( wallVector->angle ) * normLength * -1 );

                            struct Vector* paraForce = VectorInit( cos( wallVector->angle ) * paraLength , 
                                                                   sin( wallVector->angle ) * paraLength );
                                                                   
                            // resizing forces to forceEnding's length
                                                                                           
                            VectorMultiply( normForce , forceEnding->length / force->length );
                            VectorMultiply( paraForce , forceEnding->length / force->length );
                            
                            if ( hittingA == NULL )     // one wall
                            {
                            
                                hittingA = wall;
                                VectorAddTo( lastNormal , normForce );
                                VectorSet( lastParallel , paraForce->x , paraForce->y );
                                
                            }
                            else                        // two walls, calculating bisector
                            {
                            
                                hittingB = wall;
                                VectorMultiply( normForce , lastNormal->length / normForce->length );
                                VectorAddTo( lastNormal , normForce );
                                VectorSet( lastParallel , 0 , 0 );
                                
                            }
                            
                            VectorSet( lastPivot , hitX , hitY );
                            
                            // cleanup
                                                                            
                            free( wallVector );
                            free( normForce );
                            free( paraForce );
                            free( forceEnding );
                        
                        }
                        
                    }
                    
                }
                
            }
            
            // step to next wall
            
            link = link->next;

        }
        
        if ( hasCollosion ) 
        {
        
            aMass->hadCollosion = 1;

            // create final reflected ending
            
            VectorAddTo( lastParallel , lastNormal );

            // set new FINAL partial position

            VectorSet( aMass->partialForce , lastParallel->x , lastParallel->y );
            VectorSet( aMass->partialPosition , lastPivot->x , lastPivot->y );
            
            // remembering walls for sliding
        
            aMass->lastWallA = hittingA;
            aMass->lastWallB = hittingB;

        }
        
        // setting new touching walls to avoid remembering the wrong ones
            
        aMass->lastTouchedWallA = hittingA;
        aMass->lastTouchedWallB = hittingB;
        
        // cleanup
        
        free( lastPivot );
        free( lastNormal );
        free( lastParallel );

        return hasCollosion;
    
    }

@end
