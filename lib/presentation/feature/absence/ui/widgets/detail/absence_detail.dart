import 'package:absence_manager/presentation/feature/absence/bloc/absence_detail/absence_detail_bloc.dart';
import 'package:absence_manager/presentation/feature/absence/model/absence_detail_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';




class AbsenceDetailWidget extends StatefulWidget {

  final int absenceId;

  const AbsenceDetailWidget({super.key, required this.absenceId});

  @override
  State<AbsenceDetailWidget> createState() => _AbsenceDetailWidgetState();
}

class _AbsenceDetailWidgetState extends State<AbsenceDetailWidget> {


  @override
  void initState() {
    super.initState();
    BlocProvider.of<AbsenceDetailBloc>(context).add(FetchAbsenceDetailsEvent(widget.absenceId));
  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AbsenceDetailBloc, AbsenceDetailState>(
      builder: (BuildContext context, AbsenceDetailState state) {
        if (state is AbsenceDetailLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is AbsenceDetailSuccessState) {
          final AbsenceDetailModel detail = state.absenceDetailView;
          return  Padding(
              padding: const EdgeInsets.all(16.0),
              child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(detail.employeeProfile),
                          onBackgroundImageError: (_, __) => const Icon(Icons.person, size: 40),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Name: ${detail.employeeName}',
                        style: Theme.of(context).textTheme.labelMedium!.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text('Type of Absence: ${detail.type}'),
                      const SizedBox(height: 8),
                      Text('Period: ${detail.startDate} - ${detail.endDate}'),
                      if (detail.memberNote.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Text('Member Note: ${detail.memberNote}'),
                      ],
                      const SizedBox(height: 8),
                      Text(
                        'Status: ${detail.status}',
                        style: TextStyle(
                          color: _getStatusColor(detail.status),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (detail.admitterNote.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Text('Admitter Note: ${detail.admitterNote}'),
                      ],
                    ],
                  )
              ),
          );
        } else if (state is AbsenceDetailErrorState) {
          return Center(
            child: Text(
              'Error: ${state.errorMessage}',
              style: const TextStyle(color: Colors.red),
            ),
          );
        } else {
          return const Center(child: Text('No absence details found.'));
        }
      },
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Requested':
        return Colors.orange;
      case 'Confirmed':
        return Colors.green;
      case 'Rejected':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

}

