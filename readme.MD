**Overview**

The PackageMonitor project is a shell script designed to monitor the software packages installed on a Linux system using the information available in /var/log/dpkg.log. The program focuses on tracking install and remove operations for packages.

The script has two main components:

**Monitor**: Responsible for parsing and organizing data from 
/var/log/dpkg.log.

**Front-end**: Provides a user interface for analyzing and displaying the collected data.
The monitor is periodically launched using cron and processes the log file to organize the information into a structured working directory. This organization allows indexing by package name or by date. Each software package is assigned its own subdirectory within the working directory, containing the history of its install and remove operations.

The front-end script uses the organized data to provide the user with a range of functionalities.

Functionalities

1. **List of Currently Installed Packages**

Displays the names of all currently installed packages.

2. **List of Removed Packages**

Displays the names of packages that were once installed but have since been removed, along with the date of their last removal.

3. **Package History**

Shows the complete history of install and remove operations for a specific package.

4. **Operations Within a Time Interval**

Displays a list of packages installed or removed within a specified time interval.


**Installation and Setup**

Clone the Repository
Clone or copy the project files to your local machine.
Grant Execute Permissions
Ensure that the shell scripts have the appropriate permissions:

``
chmod +x monitor.sh frontend.sh
``

Configure Cron for Periodic Monitoring
Add the monitor script to cron for periodic execution:

``
crontab -e
``

Add the following line to run the monitor every hour (adjust the path as needed):

``
0 * * * * /path/to/monitor.sh
``

Run the Front-End

Execute the front-end script to analyze and display the collected data:


``
./frontend.sh
``