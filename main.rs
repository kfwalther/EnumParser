/** 
 * @file main.rs
 * @author Kevin Walther
 * @date 2018
 */ 

#[macro_use]
extern crate serde_derive;
extern crate serde_xml_rs;

pub mod enum_utilities;

// Define the main entry point to the program.
fn main () {
	// Read the enumerations from the XML file. 
	let siso_enumerated_data = enum_utilities::read_xml_file(String::from("RPR-Enumerations_v2.0_truncated.xml"));
	// Write the enumerations to a file in HLA 1.3 format.
	enum_utilities::write_enumerations_hla13(String::from("enums.txt"), siso_enumerated_data);

	println!("Successful Completion!");
}


