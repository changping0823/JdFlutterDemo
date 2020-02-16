// _id	"59f6ef443ce1fb0fb02c7a43"
// title	"笔记本电脑"
// status	"1"
// pic	"public\\upload\\UObZahqPYzFvx_C9CQjU8KiX.png"
// url	"12"

// class FocusModel{
//   String sId;
//   String title;
//   String status;
//   String pic;
//   String url;

//   FocusModel({this.sId,this.title,this.status,this.pic,this.url});

//   FocusModel.fromJson(Map jsonData){
//     this.sId = jsonData['_id'];
//     this.title = jsonData['title'];
//     this.status = jsonData['status'];
//     this.pic = jsonData['pic'];
//     this.url = jsonData['url'];
//   }
// }



class FocusModel {
  List<FocusItemModel> result;

  FocusModel({this.result});

  FocusModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = new List<FocusItemModel>();
      json['result'].forEach((v) {
        result.add(new FocusItemModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FocusItemModel {
  String sId;
  String title;
  String status;
  String pic;
  String url;

  FocusItemModel({this.sId, this.title, this.status, this.pic, this.url});

  FocusItemModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    status = json['status'];
    pic = json['pic'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['status'] = this.status;
    data['pic'] = this.pic;
    data['url'] = this.url;
    return data;
  }
}