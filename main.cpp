/**
 * @date: Oct 2018
 * @author: walther
 * @brief: Test program for the enumerations header file.
 */
 
#include <stdlib.h>
#include <iostream>
#include <string>
#include "SisoEnums.h"

int main(int numArguments, char const * const arguments[]) {
	using namespace SISO::ENTITY_TYPES::_1_3_225::GUIDED_MISSILE_DESTROYER::ARLEIGH_BURKE_CLASS::DDG_51_ARLEIGH_BURKE;
	// unsigned int EntityTypeKind = DDG_51_ARLEIGH_BURKE_E::KIND;
	// unsigned int EntityTypeDomain = DDG_51_ARLEIGH_BURKE_E::DOMAIN;
	// unsigned int EntityTypeCountry = DDG_51_ARLEIGH_BURKE_E::COUNTRY;
	// unsigned int EntityTypeCategory = DDG_51_ARLEIGH_BURKE_E::CATEGORY;
	// unsigned int EntityTypeSubcategory = DDG_51_ARLEIGH_BURKE_E::SUBCATEGORY;
	// unsigned int EntityTypeSpecific = DDG_51_ARLEIGH_BURKE_E::SPECIFIC;
	// unsigned int EntityTypeExtra = DDG_51_ARLEIGH_BURKE_E::EXTRA;

	std::cout << "Arleigh Burke Class DDG 51 Entity Type: " << std::endl;
	std::cout << "	KIND: " << static_cast<unsigned int>(DDG_51_ARLEIGH_BURKE_E::KIND) << std::endl;
	std::cout << "	DOMAIN: " << static_cast<unsigned int>(DDG_51_ARLEIGH_BURKE_E::DOMAIN) << std::endl;
	std::cout << "	COUNTRY: " << static_cast<unsigned int>(DDG_51_ARLEIGH_BURKE_E::COUNTRY) << std::endl;
	std::cout << "	CATEGORY: " << static_cast<unsigned int>(DDG_51_ARLEIGH_BURKE_E::CATEGORY) << std::endl;
	std::cout << "	SUBCATEGORY: " << static_cast<unsigned int>(DDG_51_ARLEIGH_BURKE_E::SUBCATEGORY) << std::endl;
	std::cout << "	SPECIFIC: " << static_cast<unsigned int>(DDG_51_ARLEIGH_BURKE_E::SPECIFIC) << std::endl;
	std::cout << "	EXTRA: " << static_cast<unsigned int>(DDG_51_ARLEIGH_BURKE_E::EXTRA) << std::endl;
	std::cout << "Successful Completion" << std::endl;
	return EXIT_SUCCESS;
}

