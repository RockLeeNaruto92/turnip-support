# Thuật toán Kmean và ứng dụng

## Mở đầu

Gần đây các từ khóa như Machine Learning, Data mining, Kmean, AI, ... đang rất là hot trên các cộng đồng engineer.
Tuy nhiên, mặc dù tôi là 1 engineer thế nhưng khi nghe nói đến thì cũng chỉ là nghe chứ thực sự nó là cái gì cũng không hiểu.

Dạo này thì CTO có lập 1 group để nghiên cứu AI và Machine Learning, sau đó áp dụng vào trong service của công ty, hầu hết mọi người trong team tech rất hứng thú và hứng khởi.
Tuy nhiên từ lúc vào đến giờ thì cũng chưa làm được cái gì cả mà toàn CTO + God sama làm, thế nên trong lòng cũng rất cảm thấy hổ thẹn.
Thế nên phải quyết tâm học và mong muốn có thể đóng góp được gì đấy vào trong sự nghiên cứu AI và Machine Learning của công ty.

Search trên google về machine learning, data mining, ... để tìm hiểu nó là cái gì? Nó có thể được ứng dụng như thế nào? ...
Bần tăng mới tóm lại 1 câu: ko hiểu.
Thế là bần tăng muốn tìm hiểu 1 cái thuật toán cơ bản của data mining, machine learning là Kmean xem nó hoạt động như thế nào.
Hiểu được Kmean, ứng dụng của Kmean thì có lẽ sẽ có được 1 cái nhìn gì đấy cơ bản về machine learning chăng?

Với suy nghĩ như thế, bần tăng bắt đầu google về Kmean.

## Kmean là gì?

Vừa google 1 phát thì nó ra như sau:

```
Kmean clustering  (Kmean clustering algorithms)
```

→  Clustering là cái khỉ gì vậy?
Thế là lại phải tìm hiểu cái định nghĩa clustering.

```
Clustering is the grouping of a particular set of objects based on their characteristics, aggregating them according to their similarities. Regarding to data mining, this metodology partitions the data implementing a specific join algorithm, most suitable for the desired information analysis.

`Clustering` là cách nhóm 1 tập hợp các objects dựa trên các đặc điểm, thuộc tính của chúng, tổng hợp chúng lại theo từng nhóm dựa trên ĐỘ GIỐNG NHAU (`similarities`).
Liên quan đến data mining, phương pháp này  (clustering) phân chia data bằng 1 thuật toán join được chỉ định, thích hợp nhất cho các phân tích thông tin mong muốn.
```

Lại câu hỏi đặt ra:

```
ĐỘ GIỐNG NHAU (similarities) là cái gì? Được định nghĩa như thế nào?
```

Lại google 1 lúc thì tìm được đoạn :

```
Defining similarity / dissimilarity is an important part in clustering, because it affects the structure of your groups. You need to change your measure based on the application that you have.
```

Theo ngu ý của bần tăng thì cái đoạn trên nó có nghĩa là:

```
Việc định nghĩa thế nào là GIỐNG NHAU, KHÔNG GIỐNG NHAU là 1 phần rất quan trọng trong việc phân nhóm (clustering), bởi vì nó sẽ ảnh hưởng đến toàn bộ cấu trúc của các nhóm ấy. Thí chủ cần phải thay đổi các thước đo để đánh giá GIỐNG NHAU, KHÔNG GIỐNG NHAU dựa trên các yêu cầu của application.
```

Đến đây thì tàm tạm hiểu ra:

```
Kmean nó là 1 thuật toán để phân nhóm 1 tập các object dựa trên các thuộc tính của chúng.
```

Lại tìm hiểu thêm tí nữa thì các cái thuật toán clustering được chia làm 2 nhóm chính:

- distance-based clustering algorithms: thuật toán phân nhóm dựa trên khoảng cách
- density-based clustering algorithms: thuật toán phân nhóm dựa trên mật độ

`Kmean` thuộc nhóm `distance-based clustering algorithms`. Còn ví dụ cho `density-based clustering algorithms` là `DBSCAN`.

OK. Đến đây thì tàm tạm hiểu `Kmean` nó là cái gì.
Bây giờ đi chi tiết hơn vào phần logic.

## Thuật toán

Bài toán đặt ra là: Cho n điểm trên không gian 2 chiều. Làm thế nào để phân chia thành k nhóm mà các điểm trong 1 nhóm có khoảng cách gần trọng tâm của nhóm hơn so với khoảng cách đến trọng tâm của bất kì 1 nhóm nào khác.

#### Input
- Cho n điểm. Mỗi điểm có dạng (x, y)
- k: số nhóm. k <= n

#### Output
- Danh sách k nhóm và các điểm của mỗi nhóm

#### フロー

- B1: Đầu tiên chọn random k điểm trong tập n điểm kia làm trọng tâm của k nhóm
- B2: Tính khoảng cách từ mỗi điểm đến trọng tâm `(cx, cy)` của từng nhóm
  Sử dụng công thức tính khoảng cách:

```
d(a, b) ^ 2 = (ax - bx) ^ 2 + (ay - by) ^ 2
```

- B3: Đối với mỗi điểm A, cho vào nhóm có khoảng cách từ trọng tâm nhóm đó đến điểm A là gần nhất.
- B4: Tính lại tọa độ trọng tâm cho mỗi nhóm

```
cx = SUM(a1.x + a2.x + ... + am.x) / m
cy = SUM(a1.y + a2.y + ... + am.y) / m

m: số phần từ của nhóm
```
- B5: Nếu `cx, cy` không đổi → đó là giá trị trọng tâm cần tìm.
  Else làm lại từ B2.

#### Sơ đồ khối
- Nói như trên thì hơi khó hiểu, khó hình dung nên có thể vẽ bằng sơ đồ khối thì sẽ dễ hình dung được flow hơn.

<img src='https://www.researchgate.net/profile/Guntur_Putra/publication/257923155/figure/fig3/AS:297564655112198@1447956350138/K-means-algorithm-flowchart.png'>

## Ví dụ:

#### Input
Có tập hợp 6 điểm sau:

[{x: 127, y: 933}, {x: 138, y: 741}, {x: 846, y: 391}, {x: 876, y: 879}, {x: 980, y: 580}, {x: 369, y: 725}]

#### Output
Yêu cầu: Chia 6 điểm trên làm 2 nhóm, sao cho khoảng cách từ mỗi điểm đến trọng tâm của mỗi nhóm là gần nhất.

#### Flow

Ở đây, có n = 6, k = 2.
Bần tăng sẽ diễn giải lần lượt từng bước:

- B1: Chọn random 2 điểm trong tập những điểm đã cho làm trọng tâm:
  - cendoird_point_1 = {x: 846, y: 391}
  - cendoird_point_2 = {x: 980, y: 580}

- 【LOOP1】 B2: Tính toán khoảng cách từ các điểm đến các trọng tâm:

|         | cendoird_point_1 (846, 391)           | cendoird_point_2 (980, 980)  |   group    |
| ------------- |:-------------:| -----:| -----:|
| P1(127, 933)      | 900.4026876903467  |923.1565414381247 |   1   |
| P2(138, 741)      | 789.7873131419623      |   857.2543379884409 | 1 |
| P3(846, 391) | 0.0      |   231.68297304722245 |  1 |
| P4(876, 879) | 488.9212615544552      |    316.5706872090339 | 2 |
| P5(980, 580) |231.68297304722245     |    0.0 | 2 |
| P6(369, 725) | 582.3100548676796      |    627.9697444941118 | 1 |

Sau B2, chúng tăng có được danh sách như sau:

```
Group1: [P1{x: 127, y: 933}, P2{x: 138, y: 741}, P3{x: 846, y: 391}, P6{x: 369, y: 725}]
Group2: [P4{x: 876, y: 879}, P5{x: 980, y: 580}]
```

- 【LOOP1】B3: Tính lại trọng tâm của mỗi nhóm

```
cendoird_point_1.x = SUM(P1.x + P2.x + P3.x + P6.x) / 4 = 370
cendoird_point_1.y = SUM(P1.y + P2.y + P3.y + P6.y) / 4 = 697.5

cendoird_point_2.x = SUM(P4.x + P5.x) / 2 = 928
cendoird_point_2.y = SUM(P4.y + P5.y) / 2 = 729.5
```

- 【LOOP2】B2: Quay lại tính như B2, chúng tăng lại được 1 bảng tính khoảng cách như sau:

|         | cendoird_point_1 (370, 697.5)           | cendoird_point_2 (928, 729.5)  |  old_group => new_group    |
| ------------- |:-------------:| -----:| -----:|
| P1(127, 933)      | 338.39215416436593  |826.4461567458584 |   1 => 1  |
| P2(138, 741)      | 236.04289864344574      |   790.0836980978661 | 1 => 1 |
| P3(846, 391) | 566.14331224523     |   348.2904678569312 |  1 => 2 |
| P4(876, 879) | 537.5669725717903      |    158.28534360451695 | 2 => 2 |
| P5(980, 580) |621.213530116658     |   158.28534360451695 | 2 => 2 |
| P6(369, 725) | 27.518175811634027      |    559.0181124078182 | 1 => 1 |

Sau bước này, chúng tăng có được danh sách như sau:

```
Group1: [P1{x: 127, y: 933}, P2{x: 138, y: 741}, P6{x: 369, y: 725}]
Group2: [P3{x: 846, y: 391}, P4{x: 876, y: 879}, P5{x: 980, y: 580}]
```

- [LOOP2] B3: Tính toán lại trọng tâm 2 nhóm 1 lần nữa, bần tăng được:

```
cendoird_point_1 = {x: 211.333, y: 799.667}
cendoird_point_2 = {x: 900.667, y: 616.667}
```

→ tọa độ các trọng tâm đã thay đổi, bần tăng tiếp tục quay lại B2 lần nữa:

- [LOOP3] B2: chúng tăng lại được 1 bảng tính khoảng cách như sau:

|         | cendoird_point_1 ( 211.333, 799.667)           | cendoird_point_2 (900.667, 616.667)  |  old_group => new_group    |
| ------------- |:-------------:| -----:| -----:|
| P1(127, 933)      | 157.7648369504434  |835.8392152669077 |   1 => 1  |
| P2(138, 741)      | 93.91243675892987      |   772.7351731207789 | 1 => 1|
| P3(846, 391) |754.8582103799362     |   232.19404767995243 |  2 => 2|
| P4(876, 879) | 669.3847516772398      |   263.4901587877619 | 2 => 2|
| P5(980, 580) |799.4388955873989     |   87.3967606836775 | 2 => 2|
| P6(369, 725) | 174.4535576536059      |    542.5917782071527 | 1 => 1|

Sau bước này, chúng tăng có được danh sách như sau:

```
Group1: [P1{x: 127, y: 933}, P2{x: 138, y: 741}, P6{x: 369, y: 725}]
Group2: [P3{x: 846, y: 391}, P4{x: 876, y: 879}, P5{x: 980, y: 580}]
```

- [LOOP3] B3: Tính toán lại trọng tâm 2 nhóm 1 lần nữa, bần tăng được:

```
cendoird_point_1 = {x: 211.333, y: 799.667}
cendoird_point_2 = {x: 900.667, y: 616.667}
```

→ tọa độ trong tâm của các group không đổi
→ Ơ rê ca! Kết quả đây rồi. Dừng LOOP.

#### Kết quả

Bần tăng sẽ chia 6 điểm đã cho thành 2 nhóm như sau:

```
Group1: [P1{x: 127, y: 933}, P2{x: 138, y: 741}, P6{x: 369, y: 725}]
Group2: [P3{x: 846, y: 391}, P4{x: 876, y: 879}, P5{x: 980, y: 580}]
```

## Ứng dụng thực tế của Kmean

Mặc dù đã hiểu được logic cái Kmean nó chạy như thế nào nhưng vẫn còn 1 thắc mắc được bần tăng đặt ra: thật ra làm cái Kmean này thì nó có ý nghĩa cái quái gì?

Sau khi tham khảo 1 vài ý kiến, đặc biệt là thanh niên đang học thạc sĩ khoa học máy tính tại Tokyo University, bần tăng mới ngộ ra: `Không phải hỏi thuật toán Kmean nó có ý nghĩa gì, mà phải đặt câu hỏi là: việc phân nhóm dữ liệu (clustering) nó có ý nghĩa như thế nào?`.

Giả sử 1 shop bán BCS (condom) muốn thống kê xem là BCS thường được bán cho nhóm người dùng tầm tuổi bao nhiêu, có thể sử dụng các thuật toán phân nhóm dữ liệu này để thể hiện trên biểu đồ thống kê, qua đó có thể đánh giá được nhóm độ tuổi sử dụng BCS của khách hàng, và rồi lên chiến lược quảng cáo, ...

Hoặc cũng có thể là 1 công ty có thể sử dụng các thuật toán phân nhóm dữ liệu để thống kê những nhóm lý do mà nhân viên nghỉ việc, qua đó đưa ra các chính sách ngăn chặn nhân viên nghỉ viêc dựa trên việc đánh giá kết quả phân nhóm ấy, ...

Ngoài ví dụ trên, Ccòn rất nhiều ví dụ khác ngoài tầm hiểu biết của bần tăng. Mỗi ngành, mỗi nghề, mỗi mục đích cụ thể thì có thể ứng dụng theo 1 cách khác nhau. Nhưng mà tóm cái váy chung lại thì có thể nói nó được ứng khá nhiều.

1 câu hỏi nữa được đặt ra là: `Tại sao bần tăng lại đi tìm hiểu về cái logic của Kmean này, trong khi đó thì các library nó đã viết sẵn và tối ưu hóa performance cho rồi? Học lại logic Kmean chạy thế nào rồi viết lại không phải là giống như việc phát minh lại cái bánh xa hay sao?` Về vấn đề này, bần tăng nghĩ: bần tăng tìm hiểu cái này, 1 phần là muốn hiểu bản chất của nó (Kmean) chạy như thế nào, 2 là có thể dựa vào học thuật toán giúp cho mình tăng được tư duy suy nghĩ 1 cách logic hơn nữa so với hiện tại. Cũng có thể nói học thuật toán cũng là 1 cách nâng cao năng lực bản thân vậy.

Luyên thuyên đến đây là hơi dài rồi. Bần tăng xin phép cáo từ ở đây. Bần tăng quay trở lại với chùa, quay lại với chốn bồng lai của phật pháp, quay lại với mục tiêu của bản thân và tiếp tục công cuộc nâng cao năng lực bản thân. Hi vọng tất cả chúng sanh có thể tìm được niềm vui qua bài viết này.

## Tham khảo
- https://www.youtube.com/watch?v=_aWzGGNrcic
- https://home.deib.polimi.it/matteucc/Clustering/tutorial_html/kmeans.html
- https://www.coursera.org/learn/machine-learning/lecture/93VPG/k-means-algorithm
