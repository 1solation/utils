# Fix WSL2 eating RAM

Make a `.wslconfig` file in your `C:\Users\username` folder.
In this file you can set mulitple parameters, see following options:

```
[wsl2]
kernel=              # An absolute Windows path to a custom Linux kernel.
memory=              # How much memory to assign to the WSL2 VM.
processors=          # How many processors to assign to the WSL2 VM.
swap=                # How much swap space to add to the WSL2 VM. 0 for no swap file.
swapFile=            # An absolute Windows path to the swap vhd.
localhostForwarding= # Boolean specifying if ports bound to wildcard or localhost in the WSL2 VM should be connectable from the host via localhost:port (default true).

#  N.B.
#  entries must be absolute Windows paths with escaped backslashes, for example C:\\Users\\username\\kernel
#  entries must be size followed by unit, for example 8GB or 512MB
```

Example usage:
```
[wsl2]
memory= 6GB
```
To limit WSL2 (and therefore the vmmem process) to 6GB of RAM.

Once the .wslconfig file is saved, shutdown the distro by using the `wsl.exe --shutdown [distro_name]` for the changes to propagate. Ensure you save any outstanding work before you shutdown WSL.

## Acknowledgements

  

- [Bleeping Computer article for the full read](https://www.bleepingcomputer.com/news/microsoft/windows-10-wsl2-now-allows-you-to-configure-global-options/)

