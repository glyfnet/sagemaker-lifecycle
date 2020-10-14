import urllib, os, subprocess, pwd
from crontab import CronTab

BASE_PATH = '/home/ec2-user/SageMaker'
LIFECYCLE_PATH = f'{BASE_PATH}/.lifecycle'
CONDA_PATH = f'{BASE_PATH}/.conda'
SSH_PATH = f'{BASE_PATH}/.ssh/id_rsa'

AWS_LIFECYCLE_REPOS='https://raw.githubusercontent.com/aws-samples/amazon-sagemaker-notebook-instance-lifecycle-config-samples/master/scripts'
    
def autostop(hours=24, lifecyle_path=LIFECYCLE_PATH):
    print("Fetching the autostop script")
    autostop_file= f'{lifecyle_path}/ext/autostop.py'
    wget(f'{AWS_LIFECYCLE_REPOS}/auto-stop-idle/autostop.py', autostop_file)
    timeout = hours * 3600
    
    print("Starting the SageMaker autostop script in cron")
    crontab = CronTab()
    job = crontab.new(command=f'/usr/bin/python {autostop_file} --time {timeout} --ignore-connections')
    job.minute.every(10)
    
def gitconfig(name, email):
    run(
        f'git config --global user.name "{name}"',
        f'git config --global user.email "{email}"'
    )
    
    if not os.path.isfile(SSH_PATH):
        os.makedirs(SSH_PATH, exist_ok=True)
        run(f'cat /dev/zero | ssh-keygen -f "{SSH_PATH}/id_rsa" -q -N "" -t rsa -b 4096 -C "{email}"')
    
    run(
        'eval "$(ssh-agent -s)"',
        f'ssh-add {SSH_PATH}/id_rsa' 
    )

def condaconfig():
    if not os.path.isdir(CONDA_PATH):
        os.mkdir(CONDA_PATH)
        wget(CONDA_URL, 'conda.sh')
        run(f'conda.sh -b -u -p "{CONDA_PATH}"')
        os.remove('conda.sh')
    
    projects = [p for p in os.listdir('.') if p[0] != '.']
    for project in projects:
        envfile = f'{BASE_PATH}/{project}/environment.yml'
        envdir = f'{CONDA_PATH}/env/{project}'
        
        if os.path.isfile(envfile):
            if os.path.isdir(envdir):
                conda(f'conda env update --prefix {envdir} -f {envfile} --prune')
            else:
                conda(f'conda env create -f {envfile}')
        else:
            conda(f'conda create -q -v --name {project} python=3.8')
        
        reqsfile = f'{project}/requirements.txt'
        if os.path.isfile(reqsfile):
            conda(
                f'source activate {project}', 
                f'pip -r {reqsfile}'
            )
            
    for file in os.listdir(CONDA_PATH):
        env = os.path.basename(file)
        conda(
            f'source activate {project}', 
            f'python -m ipykernel install --user --name "{env}" --display-name "Custom ({env})"'
        )

def restart():
    run('restart jupyter-server')
    
def gitclone(*repos): 
    for repo in repos:
        run(f'git clone {repo}')

def conda(*commands):
    command_str = ';'.join(commands)
    run(f'{CONDA_PATH}/bin/activate;{command_str}')
    
def wget(src, dest):
    with urllib.request.urlopen(src) as src_data:
        content = src_data.read()
        with open(dest, 'w' ) as dest_file:
            dest_file.write(content)

def run(*commands):
    return subprocess.run(
        ';'.join(commands)
    )
    
