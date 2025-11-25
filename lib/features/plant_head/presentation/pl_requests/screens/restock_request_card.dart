import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spear_me_app/core/constants/color_constants.dart';
import 'package:spear_me_app/features/plant_head/domain/entity/tool_request_entity.dart';
import 'package:spear_me_app/features/plant_head/presentation/pl_requests/bloc/request_bloc.dart';

class RestockRequestCard extends StatelessWidget {
  final RestockRequestEntity request;

  const RestockRequestCard({required this.request, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Request #${request.id}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildStatusChip(request.status),
              ],
            ),
            const Divider(),
            Row(
              children: [
                const Icon(
                  Icons.inventory,
                  size: 20,
                  color: ColorConstants.textSecondary,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    request.productName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Icon(
                  Icons.factory,
                  size: 20,
                  color: ColorConstants.textSecondary,
                ),
                const SizedBox(width: 8),
                Text(request.factoryName, style: const TextStyle(fontSize: 14)),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: ColorConstants.cardBg,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Quantity Requested:',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    '${request.qtyRequested}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: ColorConstants.primary,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                const Icon(
                  Icons.person_outline,
                  size: 16,
                  color: ColorConstants.textSecondary,
                ),
                const SizedBox(width: 4),
                Text(
                  'Requested by: ${request.requestedByUserName}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: ColorConstants.textSecondary,
                  ),
                ),
              ],
            ),
            Text(
              'Requested on: ${_formatDate(request.requestedAt)}',
              style: const TextStyle(
                fontSize: 12,
                color: ColorConstants.textSecondary,
              ),
            ),
            if (request.completedAt != null) ...[
              Text(
                'Completed on: ${_formatDate(request.completedAt!)}',
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.green,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
            if (request.status == 'PENDING') ...[
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => _completeRequest(context),
                  icon: const Icon(Icons.check_circle),
                  label: const Text('Mark as Completed'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color backgroundColor;
    Color textColor;

    switch (status) {
      case 'PENDING':
        backgroundColor = Colors.orange.shade100;
        textColor = Colors.orange.shade900;
        break;
      case 'APPROVED':
        backgroundColor = Colors.blue.shade100;
        textColor = Colors.blue.shade900;
        break;
      case 'COMPLETED':
        backgroundColor = Colors.green.shade100;
        textColor = Colors.green.shade900;
        break;
      default:
        backgroundColor = Colors.grey.shade100;
        textColor = Colors.grey.shade900;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  String _formatDate(String dateString) {
    final date = DateTime.parse(dateString);
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }

  void _completeRequest(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Complete Request'),
        content: const Text(
          'Are you sure you want to mark this restock request as completed?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<RequestBloc>().add(
                CompleteRestockRequest(request.id),
              );
              Navigator.pop(dialogContext);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Request marked as completed')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
            ),
            child: const Text('Complete'),
          ),
        ],
      ),
    );
  }
}
