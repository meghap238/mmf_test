
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_mmf/model/home_model.dart';
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
  int currentPage = 1;
  bool isLoading = false;
  List<UserList > userList = [];
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    if (isLoading) return;
    setState(() {
      isLoading = true;
    });
    var data = await ApiService().getData(widget.data.record?.authtoken ?? '', currentPage);
    if (data != null && data.userList != null) {
      setState(() {
        currentPage++;
        userList.addAll(data.userList!);
        isLoading = false;
      });
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      _fetchUsers();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          margin: EdgeInsets.only(left: 15.sp),
          height: 25.sp,
          width: 25.sp,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                image: NetworkImage(widget.data.record!.profileImg ?? ''), fit: BoxFit.cover),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.data.record!.firstName ?? 'megha',
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
      body: Padding(
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
                  padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 15.sp),
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
              child: isSelectedList ?
              ListView.builder(
                controller: _scrollController,
                itemCount: userList.length + 1,
                itemBuilder: (context, index) {
                  if (index == userList.length) {
                    return isLoading
                        ? Center(child: CircularProgressIndicator())
                        : SizedBox.shrink();
                  }
                  return Padding(
                    padding: EdgeInsets.only(bottom: 5.sp),
                    child: Card(
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.sp),
                        borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
                      ),
                      child: ListTile(
                        tileColor: Colors.white,
                        title: Row(
                          children: [
                            Text(
                              userList[index].firstName ?? 'First name',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12.sp,
                                color: Color(0xff212226),
                                fontFamily: 'Euclid',
                              ),
                            ),
                            SizedBox(width: 8.sp),
                            Text(
                              userList[index].lastName ?? 'Last name',
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
                              userList[index].email ?? 'megha',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12.sp,
                                color: Color(0xff212226),
                                fontFamily: 'Euclid',
                              ),
                            ),
                            SizedBox(width: 8.sp),
                            Text(
                              userList[index].phoneNo ?? 'Phone number',
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
                          padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 10.sp),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.sp),
                            border: Border.all(width: 1, color: Color(0xff007AFF)),
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
              ) :
              GridView.builder(
                controller: _scrollController,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
              crossAxisSpacing: 10.sp,
              mainAxisSpacing: 10.sp,
            ),
      itemCount: userList.length + 1,
      itemBuilder: (context, index) {
        if (index == userList.length) {
          return isLoading
              ? Center(child: CircularProgressIndicator())
              : SizedBox.shrink();
        }
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
                  userList[index].firstName ??'First name',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                    color: Color(0xff212226),
                    fontFamily: 'Euclid',
                  ),
                ),
                Text(
                 userList?[index].lastName ??    'Last name',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                    color: Color(0xff212226),
                    fontFamily: 'Euclid',
                  ),
                ),
                Text(
                  userList?[index].email ??  'Email Address',
                  maxLines: 1,

                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                    color: Color(0xff212226),
                    fontFamily: 'Euclid',
                  ),
                ),
                Text(
                 userList?[index].phoneNo ??     'Phone Number',
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
      ),
    );
  }
}
