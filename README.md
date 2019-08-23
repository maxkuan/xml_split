# SPLIT PATENT IN XML

## USAGE 

### Mac OS, Linux (bash script)

| Parameter     | Value                 |
| ------------- | --------------------- |
| -f, —filename | Source file           |
| -o, —output   | Folder to output file |
| -c, —count    | Null                  |

#### Split file to folder

```shell
sh xml_split.sh -f filename -o output_folder [-c]
```

#### Count patents in file

```shell
sh xml_split.sh -f filename -c
```

#### Search patent in file

`coming up...`

***

### Windows (Powershell script)

| Parameter  | Value                 | Export |
| ---------- | --------------------- | ------ |
| -filename  | Source file           |        |
| -output    | Folder to output file |        |

#### Split file to folder

```powershell
.\xmlsplit.ps1 -filename sample.xml -o output
```

#### Count patents in file

```powershell
.\xmlsplit.ps1 -filename sample.xml
```

#### Search patent in file

```powershell
.\xmlsearch.ps1 -filename sample.xml -search D0848705
```