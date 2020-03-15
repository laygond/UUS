# UUS
My Universal Usual Set-up (UUS). Template shell file for common bash commands bundled together for a faster and easier set up.

It saves you time specially if you need to set up several accounts or install commonly used packages in some cloud virtual machine where things get erased when you restart session.

It includes Deep Learning setup for Ubuntu

## House Rules
- Whenever you see `<something>` , what this means is that you are to replace this with something useful. Replace the whole thing (including the < and >).
- Whenevery you see `[something]` this usually means that this something is optional. When you run the command you may put in the something or leave it out

## Setup
Open bash terminal
```sh
 $ cd ~ 
 $ git clone https://github.com/laygond/UUS 
 $ sudo chmod +x UUS/uus.sh 
```

## Usage
Load file in terminal once through source
```sh
 $ source UUS/uus.sh [--option1] [--option2]
```
If no options are inserted then nothing happens.

## Example
Assumming you are at /UUS then
```sh
 $ source uus.sh --github --update
```
or
```sh
 $ source uus.sh -g -u
```
is equivalent to running 
```sh
 $ git config --global user.email <your_git_email>
 $ git config --global user.name <your_git_name>
 $ sudo apt-get update
 $ sudo apt-get upgrade -y 
```
So it saves you time specially if you need to set up several accounts or install commonly used packages in some cloud virtual machine where things get erased when you restart session.

## Options Available

| Long Name  | Short Name | Description |
| ---------- | ---------- | ----------- |
| --github   | -g  | initializes email and username to git config | 
| --dropbox  | -d  | install and sets up dropbox uploader: uploads to dropbox from terminal | 
| --update   | -u  | ubuntu's update and upgrade of packages | 
| --tree     | -t  | install tree: outputs directory tree structure | 
| --all      | -a  | run all options available | 
| [--add_yours!] | [-?]  | [?] | 

Explore `uus.sh` file and modify the structure to add yours!! 

## Make This Repo YOURS FOREVER
Get inside `uus.sh` and modify the github email and username variables to your own (I left mine there as an example)
```
#USER VARIABLES TO MODIFY
git_email="laygond_bryan@hotmail.com"
git_name="laygond"
```
Save and close `uus.sh`. Then at /USS run:
```sh
 $ source uus.sh -g
 ```
Now Upload it to your own (previously created) GitHub Repo:
```sh
 $ rm -rf .git
 $ git init .
 $ git remote add origin https://github.com/<your_github_user_name>/<your_repo_name> #Use an existing (previously created) repo 
```
Then just push as you would normally do to your repo
```sh
 $ git add -A
 $ git commit -m "some nice comment"
 $ git push  # You may be asked to run something else ( like --set-upstream origin master) and insert password 
```

## Bash Theory to Remember
#### Variables
- $0 - The name of the Bash script.
- $1 - $9 - The first 9 arguments to the Bash script. (As mentioned above.)
- $# - How many arguments were passed to the Bash script.
- $@ - All the arguments supplied to the Bash script.
- $? - The exit status of the most recently run process.
- $$ - The process ID of the current script.
- $USER - The username of the user running the script.
- $HOSTNAME - The hostname of the machine the script is running on.
- $SECONDS - The number of seconds since the script was started.
- $RANDOM - Returns a different random number each time is it referred to.
- $LINENO - Returns the current line number in the Bash script.

More Info on Bash Here: [TUTORIAL](https://ryanstutorials.net/bash-scripting-tutorial/)
