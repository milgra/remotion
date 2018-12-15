/*
 *  Vector.c
 *  RevengeAT
 *
 *  Created by Milan Toth on 3/9/10.
 *  Copyright 2010 __MyCompanyName__. All rights reserved.
 *
 */


#include "Vector.h"
    

	// Constructs a new vector struct with x and y
	// @param Px x coord
	// @param Py y coord

	struct Vector* VectorInit (	double aX , 
								double aY )
	{

		struct Vector* newVector = malloc( sizeof( struct Vector ) );
		
		newVector->x      = aX;
		newVector->y      = aY;
		newVector->angle  = atan2( aY , aX );
		newVector->length = sqrt ( aX * aX + aY * aY );

		return newVector;

	}


	// set vector values

    void VectorSet ( struct Vector* aVa , 
                     double aX , 
                     double aY )
    {
    
		aVa->x      = aX;
		aVa->y      = aY;
		aVa->angle  = atan2( aY , aX );
		aVa->length = sqrt ( aX * aX + aY * aY );
    
    }
    
    
    // Creates a new vector by adding the two input vectors
    // @param aVA input vector a
    // @param aVB input vector b
    
    struct Vector*  VectorAdd   (   struct Vector* aVA , 
                                    struct Vector* aVB )
    {
    
		struct Vector* newVector = malloc( sizeof( struct Vector ) );

        newVector->x      = aVA->x + aVB->x;
        newVector->y      = aVA->y + aVB->y;
		newVector->angle  = atan2( newVector->y , newVector->y );
		newVector->length = sqrt ( newVector->x * newVector->x + newVector->y * newVector->y );
        
        return newVector;
    
    }

    
    // Adds the second vector to the first vector
    // @param aVA first vector
    // @param aVB second vector
    
    void            VectorAddTo (   struct Vector* aVA , 
                                    struct Vector* aVB )
    {

        aVA->x      += aVB->x;
        aVA->y      += aVB->y;
		aVA->angle  = atan2( aVA->y , aVA->x );
		aVA->length = sqrt ( aVA->x * aVA->x + aVA->y * aVA->y );
    
    }
    

    void            VectorAddToNormalized     ( struct Vector* aVA , 
                                                struct Vector* aVB )
    {

        aVA->x += aVB->x;
        aVA->y += aVB->y;
    
        if ( aVA->length != 0 )
        {
            aVA->x /= 2;
            aVA->y /= 2;
        
        }
        
        aVA->angle  = atan2( aVA->y , aVA->x );
        aVA->length = sqrt ( aVA->x * aVA->x + aVA->y * aVA->y );
    
    }

    
    // Multiplies the vector with the given scalar
    
    void            VectorMultiply  ( struct Vector* aVA , 
                                      double         aValue )
    {
    
        aVA->x *= aValue;
        aVA->y *= aValue;
        aVA->length *= aValue;
    
    }

