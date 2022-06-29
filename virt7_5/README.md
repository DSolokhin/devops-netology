**Задача 1**  

```
solo@solo-vm:~/go$ go version
go version go1.13.8 linux/amd64
solo@solo-vm:~/go$ 
```
**Задача 2**  



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
3:  
```
package main
  import "fmt"
   func main() {
    for i := 1; i <= 100; i++ {
      if (i%3) == 0 {
        fmt.Print("[",i,"]")
      }
    }
  }
```
```
solo@solo-vm:~/go$ go run test3.go
 3  6  9  12  15  18  21  24  27  30  33  36  39  42  45  48  51  54  57  60  63  66  69  72  75  78  81  84  87  90  93  96  99
```
