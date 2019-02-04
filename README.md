# Battery Monitor for Ubuntu 16

This is a script that prompts when the battery is full, 15%, 10% and 5% and suspends automatically after a message. 
My Lenovo is has 2 batteries and so I need to take the average and then calculate the battery level, this is why I have the mathematical equations needed. 

# Setup
To setup the script, follow the steps.

First, clone the repository by using the following code: 

```
  git clone https://github.com/arishabh/battery-monitor
```

Then, go inside the directory:

```
  cd battery-monitor
```

Next, run the following code:

```
  chmod +x battery-monitor.sh
```

Lastly, search **Startup Application** and then click the **Add** button, and then select the code and name it whatever you like. This will make the code run every time you start your computer. You can add comments if you want, but it is not compulsory 

```
  Startup Applications -> Add -> Select battery-monitor.sh
```

# Output

- At 100%, it will say "Fully Charged!"
- At 15% or 14%, it will say "Battery is at 15%, Plug-in computer"
- At 10% or 11%, it will say "Battery is at 10%, Plug-in computer right now!" and also give a pop-up window
- At 5% or less, it will say "BATTERY IS VERY LOW, SUSPENDING SYSTEM IN 10 SECONDS" and give a pop-up and then suspend the computer in 10 seconds.

# Uninstall

To uninstall, go to **Startup Application** and delete the Battery Monitor you had added and delete the repository by using:
```
rm -rf battery-monitor
```
