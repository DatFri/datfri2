

import 'package:bay/features/bookings/widgets/appoint_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../../../providers/appointment_provider.dart';
import '../../providers/auth_provider.dart';
import '../palette.dart';

class BookingsPage extends StatefulWidget {
  const BookingsPage({super.key});

  @override
  State<BookingsPage> createState() => _BookingsPageState();
}


class _BookingsPageState extends State<BookingsPage>with TickerProviderStateMixin {

  late TabController tabController;
  @override
  void initState() {
    tabController = new TabController(length: 3, vsync: this);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TabController tabController = TabController(length: 3, vsync: this);
    // final appointmentProvider = Provider.of<AppointmentProvider>(context);

    return Scaffold(
      body:
      SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10,),
              Text("Bookings", style:TextStyle(fontWeight: FontWeight.w600,fontSize: 30,),),
              SizedBox(height: 5,),
              Container(
                decoration: BoxDecoration(
                  //This is for background color
                    color: Colors.white.withOpacity(0.0),
                    //This is for bottom border that is needed
                    border: Border(bottom: BorderSide(color: Colors.grey, width: 0.8))),
                child: TabBar(
                    controller: tabController,
                    labelColor: Palette.primaryDartfri,
                    unselectedLabelColor: Colors.black,
                    indicatorColor:Palette.primaryDartfri ,
                    tabs:[
                      Tab(text: "Active",),
                      Tab(text: "Finished",),
                      Tab(text: "Cancelled",),
                    ]

                ),
              ),
              Expanded(
                // width: double.maxFinite,
                  child:TabBarView(
                      controller: tabController,
                      children:  [
                        UpcomingView(),
                        FinishedView(),

                        CancelledView(),
                      ]
                  )
              ),


            ],
          ),
        ),
      ),
    );

  }
}

class CancelledView extends StatelessWidget {
  CancelledView({
    Key? key,
  }) : super(key: key);
  List appointments =[];

  @override
  Widget build(BuildContext context)  {
    final appointmentProvider = Provider.of<AppointmentProvider>(context);
    final userProvider = Provider.of<AuthProvider>(context);
    Stream<List> getAppointements () async* {
      appointments = await  appointmentProvider.caancelled_appointments ;


      yield appointments;
    }
    // List<dynamic> appointments = await appointmentProvider.getAppointments(userProvider.user.uid!);
    return StreamBuilder<Object>(
        stream: getAppointements(),
        builder: (context, snapshot) {
          return  snapshot.hasData ? Container(
            // padding: EdgeInsets.all(6),
            child: ListView.builder(

                physics: ScrollPhysics(),
                // shrinkWrap: true,
                itemCount:snapshot.hasData ? appointments.length : 0,
                scrollDirection: Axis.vertical,
                itemBuilder: (context,index){

                  return AppointmentCard(appointment: appointments[index], action:"cancel");
                }),
          ):Container();
        }
    );
  }
}

class FinishedView extends StatelessWidget {
  FinishedView({
    Key? key,
  }) : super(key: key);
  List appointments  =[];


  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<AuthProvider>(context);
    final appointmentProvider = Provider.of<AppointmentProvider>(context);
    // List appointments = appointmentProvider.appointments;
    Stream<List> getAppointements () async* {
      appointments = await  appointmentProvider.done_appointments ;

      yield appointments;
    }
    return StreamBuilder<Object>(
        stream: getAppointements(),
        builder: (context, snapshot) {
          return snapshot.hasData ? Container(
            // padding: EdgeInsets.all(6),
            child: ListView.builder(

                physics: ScrollPhysics(),
                // shrinkWrap: true,
                itemCount:snapshot.hasData ? appointments.length : 0,
                scrollDirection: Axis.vertical,
                itemBuilder: (context,index){

                  return AppointmentCard(appointment: appointments[index],action: 'finished',);
                }),
          ):Container();
        }
    );
  }
}

class UpcomingView extends StatelessWidget {
  UpcomingView({
    Key? key,
  }) : super(key: key);
  List appointments =[];
  @override
  Widget build(BuildContext context) {
    final appointmentProvider = Provider.of<AppointmentProvider>(context);
    final userProvider = Provider.of<AuthProvider>(context);

    Stream<List> getAppointements () async* {
      appointments = await  appointmentProvider.pending_appointments ;

      yield appointments;
    }
    return StreamBuilder<Object>(
        stream: getAppointements(),
        builder: (context, snapshot) {
          return snapshot.hasData ? Container(
            // padding: EdgeInsets.all(6),
              child: ListView.builder(

                  physics: ScrollPhysics(),
                  // shrinkWrap: true,
                  itemCount:snapshot.hasData ? appointments.length : 0,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context,index){

                    return AppointmentCard(appointment: appointments[index],action: 'active',);
                  })
          ):Container();
        }
    );
  }


}
