import os
import paramiko
from scp import SCPClient

def create_ssh_client(ip, username, password):
    ssh = paramiko.SSHClient()
    ssh.load_system_host_keys()
    ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    ssh.connect(ip, username=username, password=password)
    return ssh

def transfer_files_to_hosts(ip_file, files_dir, destination_path, username, password):
    with open(ip_file, 'r') as f:
        ips = [line.strip() for line in f.readlines() if line.strip()]

    files = [file for file in os.listdir(files_dir) if os.path.isfile(os.path.join(files_dir, file))]

    for ip, file in zip(ips, files):
        print(f"Connecting to {ip}...")
        try:
            ssh = create_ssh_client(ip, username, password)
            scp = SCPClient(ssh.get_transport())
            scp.put(os.path.join(files_dir,file), destination_path)
            scp.close()
            print(f"File {file} transferred successfully to {ip}:{destination_path}")
        except Exception as e:
            print(f"Failed to transfer file({file}) to {ip}: {e}")
        finally:
            ssh.close()

ip_file = 'ip_list.txt'
files_dir = '/home/spleen/5pl33n/itis/terraform/gke/keys/'
destination_path = '/home/alunno'
username = 'alunno'
password = 'password'

transfer_files_to_hosts(ip_file, files_dir, destination_path, username, password)
