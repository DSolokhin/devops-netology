**Задача 1**  

```
solo@solo-vm:~/go$ go version
go version go1.13.8 linux/amd64
solo@solo-vm:~/go$ 
```


**Задача 3**  
1:  
```
package main
  import "fmt"
  func main() {
    var foot float64
      fmt.Print("Type foot: ")
      fmt.Scanf("%f", &foot)
      result := foot * 0.3048
      fmt.Println("Meters:", result )
        }
```
```
solo@solo-vm:~/go$ go run test1.go
Type foot: 100
Meters: 30.48
```
