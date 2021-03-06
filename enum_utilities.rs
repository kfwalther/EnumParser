/** 
 * @file enum_utilities.rs
 * @author Kevin Walther
 * @date 2018
 */ 

use std;
use std::io::Write;
use std::io::Read;
//use std::io::prelude::*;
use serde_xml_rs;

// Define a struct to hold a vector of all the enumerations.
#[derive(Deserialize, Debug)]
pub struct EnumeratedDataTypes {
	#[serde(rename = "enumeratedData", default)]
	enumerated_data_list: Vec<EnumeratedData>,
}

// Define a struct to hold an enumeration and its contents.
#[derive(Deserialize, Debug)]
struct EnumeratedData {
	name: String,
	semantics: String,
	#[serde(rename = "enumerator", default)]
	enumerators: Vec<Enumerator>,
}

// Define a struct to hold a single enumerated name/value pair.
#[derive(Deserialize, Debug)]
struct Enumerator {
	name: String, 
	value: u64,
}

/** Define a function to write the EnumeratedDataTypes to a file in HLA 1.3 format. */
pub fn write_enumerations_hla13(output_file_name: String, siso_enumerated_data: EnumeratedDataTypes) -> Result<(), std::io::Error> {
	let mut output_file = std::fs::File::create(output_file_name).expect("Error creating the output file!");
	// Loop through all the EnumeratedData elements.
	for cur_enum_data in siso_enumerated_data.enumerated_data_list {
		// Print the metadata for the current EnumeratedData element.
		output_file.write_all(format!(r#"{}(EnumeratedDataType (Name "{}"){}"#, "\t", cur_enum_data.name, "\n").as_bytes())?;
		output_file.write_all(format!(r#"{}(Description "{}"){}"#, "\t\t", cur_enum_data.semantics, "\n").as_bytes())?;
		output_file.write_all(format!("{}(AutoSequence Yes){}", "\t\t", "\n").as_bytes())?;
		output_file.write_all(format!("{}(StartValue {}){}", "\t\t", cur_enum_data.enumerators[0].value.to_string(), "\n").as_bytes())?;
		// Loop through all enumerators for this enumeration.
		for cur_enumerator in cur_enum_data.enumerators {
			// Print the Enumerator info.
			output_file.write_all(format!(r#"{}(Enumeration (Enumerator "{}"){}"#, "\t\t", cur_enumerator.name, "\n").as_bytes())?;
			output_file.write_all(format!("{}(Representation {})){}", "\t\t\t\t\t ", cur_enumerator.value.to_string(), "\n").as_bytes())?;
		}
		output_file.write_all(b"\t)\n")?;
	}
	Ok(())
}

/** Define a function to read the contents of the file and put the XML into Rust structs. */
pub fn read_xml_file(xml_file_name: String) -> EnumeratedDataTypes {
	// Read in the contents of the file.
	let mut xml_file = std::fs::File::open(xml_file_name).expect("XML file not found!");
	let mut xml_text = String::new();
	xml_file.read_to_string(& mut xml_text).expect("Error when reading the XML file!");
//	println!("File contents:\n{}\n", xml_text);

	// Deserialize the XML text into Rust structs.
	let siso_enumerated_data: EnumeratedDataTypes = serde_xml_rs::deserialize(xml_text.as_bytes()).unwrap();
//	println!("{:#?}\n", siso_enumerated_data);
	siso_enumerated_data
}