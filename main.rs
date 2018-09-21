/** 
 * @file rust_example.rs
 * @author Kevin Walther
 * @date 2018
 */ 

#[macro_use]
extern crate serde_derive;
extern crate serde_xml_rs;

use std::io::prelude::*;


// Define a struct to hold a vector of all the enumerations.
#[derive(Deserialize, Debug)]
struct enumeratedDataTypes {
	#[serde(rename = "enumeratedData", default)]
	enumeratedDataList: Vec<enumeratedData>,
}

// Define a struct to hold an enumeration and its contents.
#[derive(Deserialize, Debug)]
struct enumeratedData {
	name: String,
	semantics: String,
	#[serde(rename = "enumerator", default)]
	enumerators: Vec<enumerator>,
}

// Define a struct to hold a single enumerated name/value pair.
#[derive(Deserialize, Debug)]
struct enumerator {
	name: String, 
	value: u64,
}

/** Define a function to write the enumeratedDataTypes to a file in HLA 1.3 format. */
fn write_enumerations_HLA13(output_file_name: String, siso_enumerated_data: enumeratedDataTypes) -> Result<(), std::io::Error> {
	let mut output_file = std::fs::File::create(output_file_name).expect("Error creating the output file!");
	// Loop through all the enumeratedData elements.
	for cur_enum_data in siso_enumerated_data.enumeratedDataList {
		// Print the metadata for the current enumeratedData element.
		output_file.write_all(format!(r#"{}(EnumeratedDataType (Name "{}"){}"#, "\t", cur_enum_data.name, "\n").as_bytes())?;
		output_file.write_all(format!(r#"{}(Description "{}"){}"#, "\t\t", cur_enum_data.semantics, "\n").as_bytes())?;
		output_file.write_all(format!("{}(AutoSequence Yes){}", "\t\t", "\n").as_bytes())?;
		output_file.write_all(format!("{}(StartValue {}){}", "\t\t", cur_enum_data.enumerators[0].value.to_string(), "\n").as_bytes())?;
		// Loop through all enumerators for this enumeration.
		for cur_enumerator in cur_enum_data.enumerators {
			// Print the enumerator info.
			output_file.write_all(format!(r#"{}(Enumeration (Enumerator "{}"){}"#, "\t\t", cur_enumerator.name, "\n").as_bytes())?;
			output_file.write_all(format!("{}(Representation {})){}", "\t\t\t\t\t ", cur_enumerator.value.to_string(), "\n").as_bytes())?;
		}
		output_file.write_all(b"\t)\n")?;
	}
	Ok(())
}

/** Define a function to read the contents of the file and put the XML into Rust structs. */
fn read_xml_file(xml_file_name: String) -> enumeratedDataTypes {
	// Read in the contents of the file.
	let mut xml_file = std::fs::File::open(xml_file_name).expect("XML file not found!");
	let mut xml_text = String::new();
	xml_file.read_to_string(& mut xml_text).expect("Error when reading the XML file!");
//	println!("File contents:\n{}\n", xml_text);

	// Deserialize the XML text into Rust structs.
	let siso_enumerated_data: enumeratedDataTypes = serde_xml_rs::deserialize(xml_text.as_bytes()).unwrap();
//	println!("{:#?}\n", siso_enumerated_data);
	siso_enumerated_data
}

// Define the main entry point to the program.
fn main () {
	// Read the enumerations from the XML file. 
	let siso_enumerated_data = read_xml_file(String::from("RPR-Enumerations_v2.0_truncated.xml"));
	// Write the enumerations to a file in HLA 1.3 format.
	write_enumerations_HLA13(String::from("enums.txt"), siso_enumerated_data);

	println!("Successful Completion!");
}


