## Summary

The component includes two features helping to use Git. A method to commit your changes and a method editor macro to see the history of the current opened method.

## Introduction

If you are already using project mode for development or do a regular export of your structure (Export structure file) and commit that to Git (using GitHub, GitLab, Bitbucket, etc), sooner or later you want to see the difference between two commits directly in your code.

<img src="https://github.com/ThomasMaul/Tools_TM_export/blob/master/Documentation/Diffexample.png" />

This text is assuming you already have Git installed, configured and used to commit and push your daily work. If not, at the end of this text you find some suggestions how to start.

## Please test this before usage

The component is using Console/CMD on Windows and Terminal on Mac to use Git. It requires that Git commands are correctly installed and configured.
To verify, please open on Windows cmd.exe (standard console window, not Powershell or Unix Shell), on macOS Terminal, and enter: git (return key)
This is supposed to display a long text starting with:
usage: git [--version] [--help] [-C <path>] [-c <name>=<value>]

If not, git is either not installed or correctly configured.
Especially on Windows the typical problem is a missing PATH setup.
Google will help you to find solutions, such as:
https://stackoverflow.com/questions/26620312/installing-git-in-path-with-github-client-for-windows
(scroll to Edit the path variable)

## Using Code editor to get a method history from Git

<img src="https://github.com/ThomasMaul/Tools_TM_export/blob/master/Documentation/Macro.png" />

The macro will call a 4D method, the method will call Git using Launch External Process, retrieve a history of changes, open a Window, use a list box to display the history and a web area to run a DIFF tool to compare two versions of that method.


To try that yourself, you can simply install a ready to use component. When you like what you get, you can either continue to use the component or copy the used methods and form directly into your structure.

Note: This component requires to use 4D v17 R5 or newer!

The source of the component is on Github: https://github.com/ThomasMaul/Tools_TM_export

If you don't care for the source, the compiled component can be loaded from:
https://github.com/ThomasMaul/Tools_TM_export/tree/master/Build/Components/Tools_TM.4dbase
Note: this build is compiled with 4D v17 R6, so will not run on R5 without recompilation.

Install in your structure and restart. If you are already using project mode (and your project is already using git), all should work with default settings. Just open any method (project method, form method, object method, etc) and try the macro “Git_Compare”.

If you are working in binary mode and export your structure from time to time (using Export Structure files) and you created a git repository for your export folder, you need to inform the component about the path used.

As example let's say you have your export named “MyApp_Export” at the same level as your binary based structure folder. Example:

MyApplication
--MyApplication.4DB
--MyApplication.4DIndy
--WebFolder
--Resources
MyApp_Export
--Sources
--Readme.md

In this scenario, add to your On Startup method:

$dbfolder:=Get 4D folder(Database folder)
$folder:=Path to object($dbfolder)
$gitfolder:=$folder.parentFolder+"MyApp_Export"
Tools_GitDefineFolder($gitfolder)

Of course, you could also hard code the path, the code above is more generic.

That's it. Restart (or run the On Startup), open a method and try the macro.

The list box will show the history (received using Git log).
The first line refers to the current version of this method, the newest version on disk (if using project mode) or from the binary, even if not committed to Git yet. 
The list below shows the commits with their commit message and the Git user name used to commit.

## Commit your changes

Having the history integrated, you might also want to have a comfortable way to commit your work.

As long as your Git project is correctly setup (which could have been done using Git console commands or a GUI), you can control that from 4D as well.

Simply execute method “Tools_GitCommit”. Directly executed it will open an alert asking for the commit message, you can also call the method and pass the message as parameter, to include it in your build process.

An example for an automatic build is included in method “zzbuild”. It runs Build Application (which automatically compiles if needed), then finish the build process (for this example by copying the macros into the build) and then call GitCommit.
The code could also run several build processes (like build Client/Server), upload the result to an internal server via Copy Document or an external Server via FTP, etc.

Note: if you get after commit an alert "Done, but no return message?" Git did not answered as expected. This is usually because Git don't work as console tool, check "Please test this before usage" 


## New to Git?

Git is very powerful and flexible, so a full setup guide goes far beyond the scope of this text.
So only quickly some steps needed to do:
-	If you use binary mode and not done yet, export your structure as files
-	Sign up on Github, Gitlab or other services. Or run your own, like Bitbucket on a Raspberry...Use a public or private service…
-	Create a new repository using the web interface of that service. (Don't select initialize, as you want to commit your existing local content)
-	These services will show usually some command line hints such as:
<img src="https://github.com/ThomasMaul/Tools_TM_export/blob/master/Documentation/newrepository.png" />

-	Install - if not done yet - git console tools.
-	Using Terminal (Mac) or Console (Win), cd to your working/export directory
-	Enter each line from the list above, but modify:
---	Instead using “git add README.md” enter “git add .” (a dot)
---	Replace the URL above, don't use my example, use yours!
-	In that process, when you push for the first time, it will ask for your credentials. These are stored in the local folder, so the 4D component can use them without needing to know your password.
-	If you did all correctly, your code should now be uploaded, check using the web interface of the service.

If all worked well, you can use the component as described. 
You can also use GUI tools, they are using the same concept. 
