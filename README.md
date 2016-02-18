##### Directory structure and batch scripts to create portable [SubGit] install with JRE
See this blog post for more details: https://beatcracker.wordpress.com/dummy-link

Quick how-to:

* Downlad Oracle JRE installer/archive to the `JRE_Installer` folder
* Download [SubGit] to the `Subgit` folder
* Double-click `unpack_jre.cmd` in `JRE_Installer` folder
* Edit `subgit.cmd` to set the name of the portable JRE to be used
  * e.g.: `set jre_dir=jre-8u40-windows-x64`

Now you can use `subgit.cmd` as if you were using original `subgit.bat`.

Example:
 
    c:\Path\To\SubGit-Portable>subgit --version
    SubGit version 3.0.0-EAP ('Bobique') build #3141
    This is an EAP build, which you may not like to use in production environment.
    (c) TMate Software 2012-2015 (http://subgit.com/)
    
[SubGit]: http://www.subgit.com