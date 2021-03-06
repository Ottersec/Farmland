import argparse
import os
import stat
import sys
from Modules.hunting import *
from Modules.scanning import *
from Modules.utils import *
from Modules.identifying import *
# PROBLEME WITH THE DOMAIN ON OUR LIST
def cli_parser():
    print("""\
    
  ______                   _                 _ __  __ 
 |  ____|                 | |               | /_ |/_ |
 | |__ __ _ _ __ _ __ ___ | | __ _ _ __   __| || | | |
 |  __/ _` | '__| '_ ` _ \| |/ _` | '_ \ / _` || | | |
 | | | (_| | |  | | | | | | | (_| | | | | (_| || |_| |
 |_|  \__,_|_|  |_| |_| |_|_|\__,_|_| |_|\__,_||_(_)_|
                                                                                                                                                      
                                                           
    """)
    parser = argparse.ArgumentParser(
        add_help=True, description="Farmland is a tool to automate the domain discovery"
    )
    parser.add_argument('--h',action="store_true",help=argparse.SUPPRESS)

    general_options = parser.add_argument_group('General arguments')
    general_options.add_argument('--domain','-d',dest="domain",required=True,help="Seed domain")
    general_options.add_argument('--output-dir', '-o', help="Root ouput dir", dest="outputdir",
                        default="Output/")

    general_options.add_argument('--massdns', '-s', help="Subdomain brute force using massdns", dest="massdns", required=False,
                        default=False,action="store_true")
    general_options.add_argument('--dnsrecon', '-dr', help="Find subdomains using dnsrecon. By default will only use the crt functionnality", dest="dnsrecon", required=False,
                        default=False,action="store_true")

    general_options.add_argument('--nmap','-n',help="Enable scan using nmap",dest="nmap",required=False,default=False,action="store_true")
    general_options.add_argument('--masscan', '-m', help="Enable scan using masscan", dest="masscan", required=False, default=False, action="store_true")

    general_options.add_argument('--intrigue','-i',help="Find what technologies are being used :: WIP",dest="intrigue",required=False,default=False,action="store_true")
    general_options.add_argument('--nrich', '-r', help="Quick check on InternetDB regarding CVE", dest="nrich", required=False, default=False,action="store_true")
    general_options.add_argument('--eyewitness','-e',help="Screenshot of everywebsite that we have found",dest="eyewitness",required=False,default=False,action="store_true")
    general_options.add_argument('--from-save', help="Resume the scan from a previously generated .json file",
                                 dest="from_save", required=False, default=False)

    general_options.add_argument('--skip', '-ss', help="Skip validation : yes or no (Important for docker)",
                                dest="skip", required=False, default=None,choices=["y","n"])


    dnsrecon_options = parser.add_argument_group('DNS Recon Options')
    dnsrecon_options.add_argument('--dnsrecon-bing', '-db', help="Use the bing search functionnality of DNSRecon",
                                dest="dnsrecon_bing", required=False, default=False, action="store_true")
    dnsrecon_options.add_argument('--dnsrecon-std', '-ds', help="Use the std search functionnality of DNSRecon",
                                dest="dnsrecon_std", required=False, default=False, action="store_true")

    massdns_options = parser.add_argument_group('Massdns Options')
    massdns_options.add_argument('--massdns-rate', help="Rate in pps for massdns",
                                 dest="massdns_rate", required=False, default="10000")
    massdns_options.add_argument('--massdns-wordlist', '-mw', help="Wordlist used to brute force", dest="massdns_wordlist",default="./Resources/Wordlists/small.txt")

    nmap_options = parser.add_argument_group('Nmap Options')
    nmap_options.add_argument('--nmap-ports', help="Port range using nmap syntax",
                                 dest="nmap_ports", required=False, default=False)
    eyewitness_options = parser.add_argument_group('Eyewitness Options')
    eyewitness_options.add_argument('--eyewitness-full','-ef',help="Screenshot on every domains/ports AND raw IP address that we gatehered (time consuming) but usefull for some vhost",dest="eyewitness_full",required=False,default=False,action="store_true")

    args = parser.parse_args()
    if args.h:
        parser.print_help()
    # Check if masscan is setuid or if we are root/sudo, otherwise masscan won't work
    if args.masscan:
        if os.geteuid() != 0:
            suid_result = os.stat("./Resources/Binary/masscan")
            print(os.stat("./Resources/Binary/masscan").st_mode)
            # TODO : This check does not work
            if suid_result.st_mode & stat.S_ISUID:
                parser.print_help()
                print("[!] Error : In order to use masscan you need to launch the script with root privileges or SUID masscan")
                sys.exit()
    if not args.massdns and not args.dnsrecon and not args.from_save:
        parser.print_help()
        print("[!] Error : Please select at least one of the following {massdns,crt}")
        sys.exit()
    if (args.dnsrecon_bing or args.dnsrecon_std):
        if not args.dnsrecon:
            raise parser.error("--dnsrecon-bing and --dnsrecon-std require dnsrecon to be enabled")
    if not args.masscan and not args.nmap:
        print("[!] Warning : No scan options were selected. No active scan will be performed.")
    return args

if __name__ == '__main__':
    args = cli_parser()
    if not os.path.exists(args.outputdir + args.domain):
        os.makedirs(args.outputdir + args.domain)
        os.makedirs(args.outputdir + args.domain + "/Raw/")
        os.makedirs(args.outputdir + args.domain + "/Formatted/")
    print("[Stage 1] Discovering")
    base_domain = exec_base_domain(args)
    if args.massdns:
        exec_massdns_subbbrute(args)
    if args.dnsrecon:
        exec_dnsrecon(args)
    s1_data = agregate_data_stage1(args,base_domain)
    print("[Stage 2] Scanning")
    if args.masscan or args.nmap :
        exec_massscan_nmap(s1_data,args)
    else:
        print("  [-] No scan options selected : Skipping")
    s2_data = agregate_data_stage2(s1_data,args)

    print("[Stage 3] CVE Discovery / Tech discovery")
    if not args.intrigue and not args.nrich and not args.eyewitness:
        print("  [-] No discovery options selected : Skipping")
    else:
        if args.nrich:
            exec_nrich(s2_data,args)
        if args.eyewitness:
            exec_eyewitness(s2_data,args)
        if args.intrigue:
            exec_intrigue(s2_data,args)

    s3_data = agregate_data_stage3(s2_data,args)
    write_to_xls_s3(s3_data,args)
    print("[DONE]")
