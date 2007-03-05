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
/// Resource file type plugin base class
/// </summary>
public abstract class
FilePlugin
{



/// <summary>
/// Examine a given filename and, if recognized, add its contents to a
/// given <c>ResourceWriter</c> as an object of an appropriate type
/// </summary>
/// <remarks>
/// Plugins can assume that the given file exists
/// </remarks>
/// <returns>
/// <c>true</c> if the file was recognized and processed, <c>false</c> if not
/// </returns>
public abstract bool
Process(
	string filename,
	ResourceWriter writer
);



/// <summary>
/// Write a message related to processing
/// </summary>
protected void
WriteLine(
	string message
)
{
	WriteLine( message, 0 );
}

protected void
WriteLine(
	string message,
	int indent
)
{
	if( message == null ) message = "";
	Resbian.WriteLine( message, indent+1 );
}



/// <summary>
/// Extract the local part of a resource file name
/// </summary>
/// <remarks>
/// The "local" part is everything after "&lt;type&gt;__", which is usually
/// the part that a <c>FilePlugin</c> is concerned with.
/// </remarks>
/// <returns>
/// The "local" part of the filename or, if there is no type prefix, the
/// whole filename.  Neither case includes leading directory paths.
/// </returns>
protected string
GetLocalFilename(
	string filename
)
{
	string result;
	string filenameonly = Path.GetFileName( filename );
	int pos = filenameonly.IndexOf( "__" );
	if( pos >= 0 ) {
		result = filenameonly.Substring( pos + 2 );
	} else {
		result = filenameonly;
	}
	return result;
}



} // class
} // namespace

