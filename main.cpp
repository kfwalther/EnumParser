/**
 * @date: Oct 2018
 * @author: walther
 * @brief: Test program for the enumerations header file.
 */
 
#include <stdlib.h>
#include <iostream>
#include <string>
#include "SisoRef010Enums.h"

int main(int numArguments, char const * const arguments[]) {
	using namespace SISO::ENTITY_TYPES::_1_3_225::GUIDED_MISSILE_DESTROYER::ARLEIGH_BURKE_CLASS::DDG_51_ARLEIGH_BURKE;

	/** C++11 usage example. */
	std::cout << "Arleigh Burke Class DDG 51 Entity Type (C++11): " << std::endl;
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

