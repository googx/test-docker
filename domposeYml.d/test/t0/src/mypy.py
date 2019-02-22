#!/usr/bin/python
# EASY-INSTALL-ENTRY-SCRIPT: 'docker-compose==1.8.0','console_scripts','docker-compose'
# __requires__ = 'docker-compose==1.8.0'
import pkg_resources
import psutil

# def ss(ss:pkg_resources.EntryPoint):
# ss.
# pass

if __name__ == '__main__':
    # print(psutil.users())
    pa = psutil.Process()
    psdir = dir(psutil)
    # print(psutil.users())
    requ = pkg_resources.parse_requirements(psutil)
    print(type(requ))
    requ()
    # requ.
    # for i in requ:
    #     print(i)
    info = pkg_resources.get_entry_info('docker-compose==1.8.0', 'console_scripts', 'docker-compose')
    # info1=pkg_resources.get_entry_info('psutil==5.4.8', 'console_scripts', 'users')
    # print(info.name)
    # print(info.attrs)
    # print(info.dist)
    # print(info.extras)
    # ss(info)
    # sys.exit(
    #     load_entry_point('docker-compose==1.8.0', 'console_scripts', 'docker-compose')()
    # )
