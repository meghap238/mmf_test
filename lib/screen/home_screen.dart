
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_mmf/model/login_model.dart';
import 'package:test_mmf/screen/api_service.dart';

class HomeScreen extends StatefulWidget {
  final LoginModel data;
   HomeScreen({super.key, required this.data});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isSelectedList = true;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    ApiService().getData(widget.data.record?.authtoken ?? '');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(margin: EdgeInsets.only(left: 15.sp),

          height: 25.sp,width: 25.sp,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage(widget.data.record!.profileImg ?? ''),fit: BoxFit.cover
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.data.record!.firstName ?? 'megha',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 17.sp,
                color: Color(0xff212226),
                fontFamily: 'Euclid',
              ),
            ),
            Text(
              widget.data.record!.email ?? 'megha@gmail.com',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 13.sp,
                color: Color(0xff949BA5),
                fontFamily: 'Euclid',
              ),
            ),
          ],
        ),
      ),
      body: FutureBuilder(future: ApiService().getData(widget.data.record?.authtoken  ?? ''), builder:
      (context, snapshot) {
        return  Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.sp).copyWith(top: 20.sp),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'User list',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 17.sp,
                      color: Color(0xff212226),
                      fontFamily: 'Euclid',
                    ),
                  ),
                  Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400, width: 1),
                      borderRadius: BorderRadius.circular(8.sp),
                    ),
                    padding: EdgeInsets.symmetric(
                        vertical: 10.sp, horizontal: 15.sp),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              isSelectedList = true;
                            });
                          },
                          child: Image(
                            image: AssetImage(isSelectedList
                                ? 'assets/image/selectedList.png'
                                : 'assets/image/Frame.png'),
                          ),
                        ),
                        SizedBox(width: 15.sp),
                        InkWell(
                          onTap: () {
                            setState(() {
                              isSelectedList = false;
                            });
                          },
                          child: Image(
                            image: AssetImage(isSelectedList
                                ? 'assets/image/deselecgrid.png'
                                : 'assets/image/grid.png'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.sp),
              Expanded(
                child: isSelectedList
                    ? ListView.builder(
                  itemCount: 20,
                  itemBuilder: (context, index) {

                    return Padding(
                      padding:  EdgeInsets.only(bottom: 5.sp),
                      child: Card(
                        shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.sp),
                          borderSide: BorderSide(
                              color: Colors.grey.shade400, width: 1),
                        ),
                        child: ListTile(
                          tileColor: Colors.white,
                          title: Row(
                            children: [
                              Text(
                                snapshot.data?.userList?[index].firstName ?? 'First name',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.sp,
                                  color: Color(0xff212226),
                                  fontFamily: 'Euclid',
                                ),
                              ),
                              SizedBox(width: 8.sp),
                              Text(
                                snapshot.data?.userList?[index].lastName ?? 'Last name',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.sp,
                                  color: Color(0xff212226),
                                  fontFamily: 'Euclid',
                                ),
                              ),
                            ],
                          ),
                          subtitle: Row(
                            children: [
                              Text(
                                snapshot.data?.userList?[index].email ??  'Email address',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.sp,
                                  color: Color(0xff212226),
                                  fontFamily: 'Euclid',
                                ),
                              ),
                              SizedBox(width: 8.sp),
                              Text(
                                snapshot.data?.userList?[index].phoneNo ?? 'Phone number',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.sp,
                                  color: Color(0xff212226),
                                  fontFamily: 'Euclid',
                                ),
                              ),
                            ],
                          ),
                          trailing: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.sp, vertical: 10.sp),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.sp),
                              border: Border.all(
                                  width: 1, color: Color(0xff007AFF)),
                            ),
                            child: Text(
                              'View Profile',
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 10.sp,
                                color: Color(0xff007AFF),
                                fontFamily: 'Euclid',
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                )
                    : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.sp,
                    mainAxisSpacing: 10.sp,
                  ),
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return Card(

                      color: Colors.white,
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.sp),
                        borderSide: BorderSide(
                            color: Colors.grey.shade400, width: 1),
                      ),
                      child: Padding(
                        padding:  EdgeInsets.all(20.sp),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              snapshot.data?.userList?[index].firstName ?? 'First name',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12.sp,
                                color: Color(0xff212226),
                                fontFamily: 'Euclid',
                              ),
                            ),
                            Text(
                              snapshot.data?.userList?[index].lastName ??    'Last name',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12.sp,
                                color: Color(0xff212226),
                                fontFamily: 'Euclid',
                              ),
                            ),
                            Text(
                              snapshot.data?.userList?[index].email ??  'Email Address',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12.sp,
                                color: Color(0xff212226),
                                fontFamily: 'Euclid',
                              ),
                            ),
                            Text(
                              snapshot.data?.userList?[index].phoneNo ??     'Phone Number',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12.sp,
                                color: Color(0xff212226),
                                fontFamily: 'Euclid',
                              ),
                            ),
                            Spacer(),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.sp, vertical: 10.sp),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.sp),
                                border: Border.all(
                                    width: 1, color: Color(0xff007AFF)),
                              ),
                              child: Text(
                                'View Profile',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 10.sp,
                                  color: Color(0xff007AFF),
                                  fontFamily: 'Euclid',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },)

    );
  }
}
