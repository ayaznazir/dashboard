class Dashboard {
  Dashboard? dashboard;
  List<Blocks>? blocks;
  Status? status;

  Dashboard({this.dashboard, this.blocks, this.status});

  Dashboard.fromJson(Map<String, dynamic> json) {
    dashboard = json['dashboard'] != null
        ? new Dashboard.fromJson(json['dashboard'])
        : null;
    if (json['blocks'] != null) {
      blocks = <Blocks>[];
      json['blocks'].forEach((v) {
        blocks!.add(new Blocks.fromJson(v));
      });
    }
    status =
    json['status'] != null ? new Status.fromJson(json['status']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dashboard != null) {
      data['dashboard'] = this.dashboard!.toJson();
    }
    if (this.blocks != null) {
      data['blocks'] = this.blocks!.map((v) => v.toJson()).toList();
    }
    if (this.status != null) {
      data['status'] = this.status!.toJson();
    }
    return data;
  }
}

class Dashboard2 {
  List<Tags>? tags;

  Dashboard2({this.tags});

  Dashboard2.fromJson(Map<String, dynamic> json) {
    if (json['tags'] != null) {
      tags = <Tags>[];
      json['tags'].forEach((v) {
        tags!.add(new Tags.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.tags != null) {
      data['tags'] = this.tags!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tags {
  String? tag;
  int? total;
  Poll? poll;
  Status? status;

  Tags({this.tag, this.total, this.poll, this.status});

  Tags.fromJson(Map<String, dynamic> json) {
    tag = json['tag'];
    total = json['total'];
    poll = json['poll'] != null ? new Poll.fromJson(json['poll']) : null;
    status =
    json['status'] != null ? new Status.fromJson(json['status']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tag'] = this.tag;
    data['total'] = this.total;
    if (this.poll != null) {
      data['poll'] = this.poll!.toJson();
    }
    if (this.status != null) {
      data['status'] = this.status!.toJson();
    }
    return data;
  }
}

class Poll {
  int? good;
  int? bad;

  Poll({this.good, this.bad});

  Poll.fromJson(Map<String, dynamic> json) {
    good = json['good'];
    bad = json['bad'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['good'] = this.good;
    data['bad'] = this.bad;
    return data;
  }
}

class Status {
  String? tag;
  int? finished;
  int? pending;
  int? hold;

  Status({this.tag, this.finished, this.pending, this.hold});

  Status.fromJson(Map<String, dynamic> json) {
    tag = json['tag'];
    finished = json['finished'];
    pending = json['pending'];
    hold = json['hold'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tag'] = this.tag;
    data['finished'] = this.finished;
    data['pending'] = this.pending;
    data['hold'] = this.hold;
    return data;
  }
}

class Blocks {
  int? id;
  String? device;
  String? crDate;
  String? name;
  String? mobile;
  String? product;
  int? status;
  int? feedback;

  Blocks(
      {this.id,
        this.device,
        this.crDate,
        this.name,
        this.mobile,
        this.product,
        this.status,
        this.feedback});

  Blocks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    device = json['device'];
    crDate = json['CrDate'];
    name = json['name'];
    mobile = json['mobile'];
    product = json['product'];
    status = json['Status'];
    feedback = json['feedback'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['device'] = this.device;
    data['CrDate'] = this.crDate;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['product'] = this.product;
    data['Status'] = this.status;
    data['feedback'] = this.feedback;
    return data;
  }
}

class Status2 {
  bool? success;
  int? code;
  String? message;

  Status2({this.success, this.code, this.message});

  Status2.fromJson(Map<String, dynamic> json) {
    success = json['Success'];
    code = json['Code'];
    message = json['Message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Success'] = success;
    data['Code'] = code;
    data['Message'] = message;
    return data;
  }
}