#!/bin/python3

import socket # Socket Library
from IPy import IP # IP Library
# Scan the Ip address and print out the port that are open
# It collects the translated IP address for check ip function and scans it against a range of ports
def scan(target): # Function that scan the target and returns the opened ports on the target.
    converted_ip = check_ip(target) # output of the check_ip is assigned to the variable converted_ip
    print('\n' + '[-_ 0 scanning Target]' + str(target))
    for port in range(1, 500): # A forloop for scanning in the range between 1 & 50
        scan_port(converted_ip, port) # Calling the scan_port function with the converted IP address and port as it arguments
    

def check_ip(ip): # function creates from IP Library to map webhostname to ip address.
    try:
        try:
            IP(ip)
            return(ip)
        except ValueError:
            return socket.gethostbyname(ip) # maps hostname to it IP address
    except: #(socket.gaierror) as err:
        pass


            
def get_banner(s): # Banner grabbing using socket function
    return s.recv(1024)

def scan_port(ipaddress, port): # scan_port function with ipaddress and port as it parameter
    try:
        sock = socket.socket() # creates the socket object sock for other content manangement
        sock.settimeout(0.5) # a socket object that set the amount of time used to scan each port
        sock.connect ((ipaddress, port)) # socket object that is use for establishing connection to internet
        try:
            banner = get_banner(sock)
            print(' [+] Open port ' + str(port) + ' : ' + str(banner.decode().strip('\n')))
        except:
            print(' [+] Open Port ' + str(port))
    except:
        pass

if __name__=="__main__":        
    targets = input('[+] Enter Target/s to scan(split multiple target with ,:) ') # To enable us to scan   website address directly

    if ',' in targets:
        for ip_add in targets.split(','):
            scan(ip_add.strip(' '))
    else:
        scan(targets)  
    		
