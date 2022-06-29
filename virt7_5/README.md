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
2:  
```
package main
  import "fmt"
  func main() {
    x := []int{48,2, 96,86,3,68,57,82,63,70,37,34,83,27,19,97,9,17,1}
    zero := 0
    for i, less := range x {
      if (i == 0) {
        zero = less
      } else {
        if (less < zero) {
          zero = less
        }
      }
      }
    fmt.Println("Min integer: ", zero)
  }
```
```
solo@solo-vm:~/go$ go run test2.go
Min integer:  1
```
