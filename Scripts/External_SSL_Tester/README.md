# ExternalSSLTester.ps1 #
## About ##
This PowerShell script can be used to check the SSL implementations of any public facing server. To achieve this, the script consumes the SSL Labs Assessment Api using a .NET library called SSLLWrapper which is a wrapper for the SSL Labs Api. This wrapper is also written by myself and can be found at [GitHub](https://github.com/AshleyPoole/SSLLWrapper), [NuGet](https://www.nuget.org/packages/SSLLWrapper/) or [My Website](http://www.ashleypoole.co.uk/ssllwrapper).

## Usage ##
ExternalSSLTester.ps1 can be invoked for use with a single host or a predefined selection of hosts which are passed in as a file path. Below are examples of both options:

**Single Host**  
`ExternalSSLTester.ps1 https://www.ashleypoole.co.uk`   
`ExternalSSLTester.ps1 -host https://www.ashleypoole.co.uk`

**Multiple Hosts**  
`ExternalSSLTester.ps1 -hosts "C:\HostsToCheck.txt"`  

**Detailed Output**  
The script can also be instructed to give a more detailed output for a host's endpoints by using the 'details' parameter. Examples below:  
`ExternalSSLTester.ps1 https://www.ashleypoole.co.uk -endpointdetails $True`   
`ExternalSSLTester.ps1 -host https://www.ashleypoole.co.uk -endpointdetails $True` 
