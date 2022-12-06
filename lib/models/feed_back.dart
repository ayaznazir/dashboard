class FeedBackDetail {
  FeedbackDetails? feedbackDetails;
  Status? status;

  FeedBackDetail({this.feedbackDetails, this.status});

  FeedBackDetail.fromJson(Map<String, dynamic> json) {
    feedbackDetails = json['feedbackDetails'] != null
        ? new FeedbackDetails.fromJson(json['feedbackDetails'])
        : null;
    status =
    json['status'] != null ? new Status.fromJson(json['status']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.feedbackDetails != null) {
      data['feedbackDetails'] = this.feedbackDetails!.toJson();
    }
    if (this.status != null) {
      data['status'] = this.status!.toJson();
    }
    return data;
  }
}

class FeedbackDetails {
  Block? block;
  List<Questions>? questions;
  List<Logs>? logs;

  FeedbackDetails({this.block, this.questions, this.logs});

  FeedbackDetails.fromJson(Map<String, dynamic> json) {
    block = json['block'] != null ? new Block.fromJson(json['block']) : null;
    if (json['questions'] != null) {
      questions = <Questions>[];
      json['questions'].forEach((v) {
        questions!.add(new Questions.fromJson(v));
      });
    }
    if (json['logs'] != null) {
      logs = <Logs>[];
      json['logs'].forEach((v) {
        logs!.add(new Logs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.block != null) {
      data['block'] = this.block!.toJson();
    }
    if (this.questions != null) {
      data['questions'] = this.questions!.map((v) => v.toJson()).toList();
    }
    if (this.logs != null) {
      data['logs'] = this.logs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Block {
  int? id;
  String? device;
  String? crDate;
  String? name;
  String? mobile;
  String? product;
  int? status;
  int? feedback;

  Block(
      {this.id,
        this.device,
        this.crDate,
        this.name,
        this.mobile,
        this.product,
        this.status,
        this.feedback});

  Block.fromJson(Map<String, dynamic> json) {
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

class Questions {
  int? orderId;
  int? id;
  String? qEnglish;
  String? qArabic;
  int? type;
  String? dataType;
  int? minLength;
  int? maxLength;
  List<Answers>? answers;
  String? selectedAnswer;

  Questions(
      {this.orderId,
        this.id,
        this.qEnglish,
        this.qArabic,
        this.type,
        this.dataType,
        this.minLength,
        this.maxLength,
        this.answers,
        this.selectedAnswer});

  Questions.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    id = json['id'];
    qEnglish = json['qEnglish'];
    qArabic = json['qArabic'];
    type = json['type'];
    dataType = json['dataType'];
    minLength = json['minLength'];
    maxLength = json['maxLength'];
    if (json['answers'] != null) {
      answers = <Answers>[];
      json['answers'].forEach((v) {
        answers!.add(new Answers.fromJson(v));
      });
    }
    selectedAnswer = json['selected_answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderId'] = this.orderId;
    data['id'] = this.id;
    data['qEnglish'] = this.qEnglish;
    data['qArabic'] = this.qArabic;
    data['type'] = this.type;
    data['dataType'] = this.dataType;
    data['minLength'] = this.minLength;
    data['maxLength'] = this.maxLength;
    if (this.answers != null) {
      data['answers'] = this.answers!.map((v) => v.toJson()).toList();
    }
    data['selected_answer'] = this.selectedAnswer;
    return data;
  }
}

class Answers {
  int? id;
  int? qId;
  String? aEnglish;
  String? aArabic;
  int? image;
  String? url;

  Answers(
      {this.id, this.qId, this.aEnglish, this.aArabic, this.image, this.url});

  Answers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    qId = json['qId'];
    aEnglish = json['AEnglish'];
    aArabic = json['AArabic'];
    image = json['image'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['qId'] = this.qId;
    data['AEnglish'] = this.aEnglish;
    data['AArabic'] = this.aArabic;
    data['image'] = this.image;
    data['url'] = this.url;
    return data;
  }
}

class Logs {
  int? id;
  int? feedbackid;
  String? crDate;
  String? user;
  String? remarks;

  Logs({this.id, this.feedbackid, this.crDate, this.user, this.remarks});

  Logs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    feedbackid = json['feedbackid'];
    crDate = json['CrDate'];
    user = json['user'];
    remarks = json['remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['feedbackid'] = this.feedbackid;
    data['CrDate'] = this.crDate;
    data['user'] = this.user;
    data['remarks'] = this.remarks;
    return data;
  }
}

class Status {
  bool? success;
  int? code;
  String? message;

  Status({this.success, this.code, this.message});

  Status.fromJson(Map<String, dynamic> json) {
    success = json['Success'];
    code = json['Code'];
    message = json['Message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Success'] = this.success;
    data['Code'] = this.code;
    data['Message'] = this.message;
    return data;
  }
}