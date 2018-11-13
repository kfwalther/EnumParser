/**
 * @date: Oct 2018
 * @author: walther
 * @brief: Test program for the enumerations header file.
 */
 
#include <stdlib.h>
#include <iostream>
#include <string>
#include "SisoRef010EnumsC99.h"

int main(int numArguments, char const * const arguments[]) {
	using namespace SISO::ENTITY_TYPES::_1_3_225::GUIDED_MISSILE_DESTROYER::ARLEIGH_BURKE_CLASS::DDG_51_ARLEIGH_BURKE;

	/** C-99 usage example. */
	DDG_51_ARLEIGH_BURKE_E ddg51EnumKind = KIND;
	DDG_51_ARLEIGH_BURKE_E ddg51EnumDomain = DOMAIN;
	DDG_51_ARLEIGH_BURKE_E ddg51EnumCountry = COUNTRY;
	DDG_51_ARLEIGH_BURKE_E ddg51EnumCategory = CATEGORY;
	DDG_51_ARLEIGH_BURKE_E ddg51EnumSubcategory = SUBCATEGORY;
	DDG_51_ARLEIGH_BURKE_E ddg51EnumSpecific = SPECIFIC;
	DDG_51_ARLEIGH_BURKE_E ddg51EnumExtra = EXTRA;
	std::cout << "Arleigh Burke Class DDG 51 Entity Type (C-99): " << std::endl;
	std::cout << "	KIND: " << static_cast<unsigned int>(ddg51EnumKind) << std::endl;
	std::cout << "	DOMAIN: " << static_cast<unsigned int>(ddg51EnumDomain) << std::endl;
	std::cout << "	COUNTRY: " << static_cast<unsigned int>(ddg51EnumCountry) << std::endl;
	std::cout << "	CATEGORY: " << static_cast<unsigned int>(ddg51EnumCategory) << std::endl;
	std::cout << "	SUBCATEGORY: " << static_cast<unsigned int>(ddg51EnumSubcategory) << std::endl;
	std::cout << "	SPECIFIC: " << static_cast<unsigned int>(ddg51EnumSpecific) << std::endl;
	std::cout << "	EXTRA: " << static_cast<unsigned int>(ddg51EnumExtra) << std::endl;
	
	std::cout << "Successful Completion" << std::endl;
	return EXIT_SUCCESS;
}

