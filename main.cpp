/**
 * @date: Oct 2018
 * @author: walther
 * @brief: Test program for the enumerations header file.
 */
 
#include <stdlib.h>
#include <iostream>
#include "SisoEnums.h"

int main(int numArguments, char const * const arguments[]) {
	auto ArleighBurkeEnum = SISO::ENTITY_TYPES::_1_3_225::GUIDED_MISSILE_DESTROYER::ARLEIGH_BURKE_CLASS::DDG_51_ARLEIGH_BURKE::DDG_51_ARLEIGH_BURKE_E;
	unsigned int EntityTypeKind = ArleighBurkeEnum::KIND;
	unsigned int EntityTypeDomain = ArleighBurkeEnum::DOMAIN;
	unsigned int EntityTypeCountry = ArleighBurkeEnum::COUNTRY;
	unsigned int EntityTypeCategory = ArleighBurkeEnum::CATEGORY;
	unsigned int EntityTypeSubcategory = ArleighBurkeEnum::SUBCATEGORY;
	unsigned int EntityTypeSpecific = ArleighBurkeEnum::SPECIFIC;
	unsigned int EntityTypeExtra = ArleighBurkeEnum::EXTRA;

	std::cout << "Arleigh Burke Class DDG 51 Entity Type: " << std::endl;
	std::cout << "	KIND: " << EntityTypeKind << std::endl;
	std::cout << "	DOMAIN: " << EntityTypeDomain << std::endl;
	std::cout << "	COUNTRY: " << EntityTypeCountry << std::endl;
	std::cout << "	CATEGORY: " << EntityTypeCategory << std::endl;
	std::cout << "	SUBCATEGORY: " << EntityTypeSubcategory << std::endl;
	std::cout << "	SPECIFIC: " << EntityTypeSpecific << std::endl;
	std::cout << "	EXTRA: " << EntityTypeExtra << std::endl;
	std::cout << "Successful Completion" << std::endl;
	return EXIT_SUCCESS;
}

