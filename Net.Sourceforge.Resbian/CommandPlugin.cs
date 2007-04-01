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



namespace
Net.Sourceforge.Resbian
{



/// <summary>
/// Command plugin base class
/// </summary>
/// <remarks>
/// The Resbian program can perform a number of different operations.  The
/// first thing provided on the command line is a command specifying the
/// particular operation you want.  Each command is implemented in a
/// CommandPlugin subclass.
/// </remarks>
public abstract class
CommandPlugin
{



/// <summary>
/// Provide help for the command
/// </summary>
/// <remarks>
/// Returned string will be displayed to the user following the program
/// and command names, on the same line ie. start with plugin-local
/// commandline arguments
/// </remarks>
public abstract string
Help();



/// <summary>
/// Perform processing that the plugin implements
/// </summary>
/// <returns>
/// <c>true</c> if successful, <c>false</c> if not
/// </returns>
public abstract bool
Process(
    string[] args
);



} // class
} // namespace

