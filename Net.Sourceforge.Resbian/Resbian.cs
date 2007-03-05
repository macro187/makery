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
using System.Collections;


namespace
Net.Sourceforge.Resbian
{



public class
Resbian
{



// Command plugin list
private static Hashtable
plugins = new Hashtable();



/// <summary>
/// The <c>resbian</c> program
/// </summary>
/// <remarks>
/// Usage:
/// resbian compile &lt;infiles&gt; &lt;out&gt;.resources
/// 	Compile &lt;infiles&gt; into &lt;out&gt;.resources
/// TODO: resbian extract &lt;in&gt;.resources &lt;outdir&gt;
/// 	Extract resources from &lt;in&gt;.resources into files in &lt;outdir&gt;
/// TODO: resbian getstrings &lt;srcs&gt; &lt;outdir&gt;
/// 	Builds &lt;type&gt;__strings.txt file(s) in &lt;outdir&gt; containing strings from
/// 	all _S("...") instances in &lt;srcs&gt;
/// TODO: resbian merge &lt;fromdir&gt; &lt;todir&gt;
/// 	Merge new strings.txt keys from files in &lt;fromdir&gt; and comment out
/// 	unused keys in files in &lt;todir&gt;. Creates new files as necessary.
/// TODO: resbian status &lt;resdir&gt;
/// 	Show translation status for each culture subdir
/// </remarks>
public static int
Main(
	string[] args
)
{
	int result = 0;
	try {

	
	// Initialize command plugin list
	plugins.Add( "compile", new CompileCommandPlugin() );
	// plugins.Add( "...", new ...() );


	// Command = first arg
	if( args.Length <= 0 ) {
		throw new CmdArgException( "No command specified" );
	}
	string command = args[0];
	

	// Command-local args = remaining args
	string[] localargs = new string[args.Length-1];
	Array.Copy( args, 1, localargs, 0, args.Length-1 );


	// Invoke plugin for specified command to do the rest
	if( plugins.ContainsKey( command ) ) {
		CommandPlugin plugin = (CommandPlugin) plugins[ command ];
		bool presult = plugin.Process( localargs );
		result = presult ? 0 : 1;
	} else {
		throw new CmdArgException( "Unrecognized command '" + command + "'" );
	}
	

	} catch( CmdArgException e ) {
		WriteLine( "" );
		WriteLine( e.Message );
		WriteLine( "" );
		WriteLine( Usage() );
		result = 1;
	}
	return result;
}



private static string
Usage()
{
	string s = "Usage:\n";
	foreach( DictionaryEntry entry in plugins ) {
		string command			= (string) entry.Key;
		CommandPlugin plugin	= (CommandPlugin) entry.Value;
		s += "resbian " + command + " " + plugin.Help();
		if( !s.EndsWith( "\n" ) )
			s += "\n";
	}
	return s;
}



public static void
WriteLine( string message )
{
	WriteLine( message, 0 );
}


public static void
WriteLine( string message, int indent )
{
	if( message == null ) message = "";
	string s = new String( '\t', indent );
	Console.Error.WriteLine(
		"{0}{1}",
		s,
		message.Replace( "\n", "\n" + s )
	);
}



} // class
} // namespace

