extern crate failure;

use failure::Error;
use std::io::{BufRead, BufReader, Read, Write};

pub fn answers(input: impl Read, mut _output: impl Write) -> Result<(), Error> {
    let input = BufReader::new(input);

    for _line in input.lines() {}
    Ok(())
}
