# rack-security WebApp Sec Middleware for Rack Applications
Copyright 2010, Ryan Stenhouse <ryan@ryanstenhouse.eu>

rack-security is Free Software, made available under the Creative Commons Attribution-Share 
Alike 2.5 UK: Scotland licence. The body of the licence is available in the COPYING file 
acompanying this package. You may [view the CC Deed here][1] if you want a quick overview.


## About

rack-security is designed to be a simple Application Firewall which can easily be inserted into
any Rack compatible application as Middleware to protect your application from common security
threats.

It will provide protection against:

 * SQL Injection Attacks
 * NULL-Byte Injection Attacks

Eventually it will be expanded to provide comprehensive protection against most of the
applicable [OWASP Top Ten][2] security threats for Web Applications. 

## How it Works

It as quickly as possible scans incoming requests against a set of patterns designed 
to detect common SQL Injection and other attacks. 

All action taken is logged to avoid confusion with requests being modified before
reaching your application.

## Important information

This is not a guaranteed security solution for your application. It uses widely published
regular expressions to perform simple pattern matching on requests. It is not very clever
and may lead to some interesting false-positives.

Using this middleware may provide protection to every Rack application, but it does not
excuse developers from the responsibility of following good coding practices and properly
checking and sanitising values. 


## Installation

TODO: Probably a GEM

## Usage

TODO

## Contact

Ryan Stenhouse by e-mail at ryan@ryanstenhouse.eu


[1]: http://creativecommons.org/licenses/by-sa/2.5/scotland/
[2]: http://www.owasp.org/index.php/Category:OWASP_Top_Ten_Project

