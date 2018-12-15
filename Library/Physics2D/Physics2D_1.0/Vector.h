/*
 *  Vector.h
 *  RevengeAT
 *
 *  Created by Milan Toth on 3/9/10.
 *  Copyright 2010 __MyCompanyName__. All rights reserved.
 *
 */
 
 
	#ifndef FILE_VECTOR
	#define FILE_VECTOR
    
    #include <math.h>
	#include <stdio.h>
	#include <stdlib.h>
 

    // Vector structure

	struct Vector
	{

		double x;
		double y;
		double angle;
		double length;
		
	};


	struct Vector*	VectorInit      ( double aX , double aY );
    void            VectorSet       ( struct Vector* aVa , double aX , double aY );
    struct Vector*  VectorAdd       ( struct Vector* aVA , struct Vector* aVB );
    void            VectorAddTo     ( struct Vector* aVA , struct Vector* aVB );
    void            VectorMultiply  ( struct Vector* aVA , double aValue );
    void            VectorAddToNormalized     ( struct Vector* aVA , struct Vector* aVB );

	#endif
