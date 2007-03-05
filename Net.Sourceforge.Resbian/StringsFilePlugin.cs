// -----------------------------------------------------------------------------
// Copyright (c) 2007 Ron MacNeil <macro187 AT users DOT sourceforge DOT net>
//
// Permission to use, copy, modify, and distribute this software for any
// purpose with or without fee is hereby granted, provided that the above
// copyright notice and this permission notice appear in all copies.
//
// THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
// WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
// MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
// ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
// WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
// ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
// OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
// -----------------------------------------------------------------------------


using System;
using System.Resources;
using System.IO;



namespace
Net.Sourceforge.Resbian
{



/// <summary>
/// FilePlugin that adds entries in <c>&lt;type&gt;__strings.txt</c> strings
/// tables as <c>string</c> resources
/// </summary>
/// <remarks>
/// <p>
/// String tables are text files containing pairs of lines separated by one or
/// more blank lines.  The first line of each pair is the string as it appears
/// in the source code, and the second line is the localized version:
/// <code>
/// Hello my friend
/// Bonjour mon ami
///
/// # This is a comment
/// Goodbye!
/// Au revoir!
///
/// ...
/// </code>
/// </p>
/// <p>
/// Each localized string is added as a <c>string</c> resource whose name is
/// the source string prefixed by <c>_S_</c>.
/// </p>
/// </remarks>
public class
StringsFilePlugin
	: FilePlugin
{


private static readonly string
FILENAME = "strings.txt";

private static readonly string
RESNAME_PREFIX = "__";


public override bool
Process(
	string filename,
	ResourceWriter writer
)
{
	// Handle "<type>__strings.txt" only
	string local = this.GetLocalFilename( filename );
	if( local != FILENAME )
		return false;

	// Grab lines from the text file
	string[] lines = File.ReadAllLines( filename );

	// Loop through lines
	int added = 0;
	int linenum = 0;
	string s = "";
	string l = "";
	string state = "s";  // what are we expecting? "s", "l", or ""
	foreach( string line in lines ) {
		linenum++;

		// Skip comments
		if( line.StartsWith( "#" ) ) continue;

		bool isblank = (line.Trim() == "" );

		switch( state ) {

		// Expecting: Source string
		case "s":
			if( isblank ) continue;
			s = line;
			state = "l";
			break;

		// Expecting: Localized string
		case "l":
			if( isblank ) {
				WriteLine( "Warning: Missing localized version of string" );
				WriteLine( String.Format(
					"File: {0}\n" +
					"Line: {1}\n" +
					"String: '{2}'",
					filename,
					linenum,
					s
				), 1 );
				state = "s";
				continue;
			}
			l = line;
			// TODO: maintain already-added list and don't add if in there 
			string name = RESNAME_PREFIX + s;
			writer.AddResource( name, l );
			added++;
			state = "";
			break;

		// Expecting: Blank line
		case "":
			if( !isblank ) {
				WriteLine( "Error: Too many lines in a row, ignoring extra" );
				WriteLine( String.Format(
					"File: {0}\n" +
					"Line: {1}\n" +
					filename,
					linenum
				), 1 );
				continue;
			}
			state = "s";
			break;

		default:
			throw new Exception( "BUG: Invalid state" );
		}

	}

	WriteLine( String.Format( "Added {0} string resources", added ) );

	return true;
}



} // class
} // namespace

