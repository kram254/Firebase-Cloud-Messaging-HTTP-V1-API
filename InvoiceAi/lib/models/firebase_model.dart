import 'dart:convert';

class FirebaseToken {
    FirebaseToken({
        this.fid,
        this.token,
        this.deleatedAt,
        this.createdAt,
        this.updatedAt,
        this.id,
    });

    String? fid;
    String? token;
    DateTime? deleatedAt;
    DateTime? createdAt;
    DateTime? updatedAt;
    String? id;

    FirebaseToken copyWith({
        String? fid,
        String? token,
        DateTime? deleatedAt,
        DateTime? createdAt,
        DateTime? updatedAt,
        String? id,
    }) => 
        FirebaseToken(
            fid: fid ?? this.fid,
            token: token ?? this.token,
            deleatedAt: deleatedAt ?? this.deleatedAt,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            id: id ?? this.id,
        );

    factory FirebaseToken.fromJson(String str) => FirebaseToken.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory FirebaseToken.fromMap(Map<String, dynamic> json) => FirebaseToken(
        fid: json["fid"],
        token: json["token"],
        deleatedAt: json["deleatedAt"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        id: json["id"],
    );

    Map<String, dynamic> toMap() => {
        "fid": fid,
        "token": token,
        "deleatedAt": deleatedAt,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "id": id,
    };
}
