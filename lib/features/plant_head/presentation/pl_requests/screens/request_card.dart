// features/plant_head/presentation/widgets/tool_request_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spear_me_app/core/constants/color_constants.dart';
import 'package:spear_me_app/features/plant_head/domain/entity/tool_request_entity.dart';
import 'package:spear_me_app/features/plant_head/presentation/pl_requests/bloc/request_bloc.dart';

class ToolRequestCard extends StatelessWidget {
  final ToolRequestEntity request;

  const ToolRequestCard({
    required this.request,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
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
                  'Request #${request.requestId}',
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
                  Icons.person,
                  size: 20,
                  color: ColorConstants.textSecondary,
                ),
                const SizedBox(width: 8),
                Text(
                  request.workerName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'Tools Requested:',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: ColorConstants.textSecondary,
              ),
            ),
            ...List.generate(
              request.toolNames.length,
              (index) => Padding(
                padding: const EdgeInsets.only(left: 16, top: 4),
                child: Row(
                  children: [
                    const Icon(Icons.circle, size: 6),
                    const SizedBox(width: 8),
                    Text(
                      '${request.toolNames[index]} (Qty: ${request.quantities[index]})',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Requested on: ${_formatDate(request.createdAt)}',
              style: const TextStyle(
                fontSize: 12,
                color: ColorConstants.textSecondary,
              ),
            ),
            if (request.rejectionReason != null) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.info_outline, color: Colors.red, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Rejection Reason: ${request.rejectionReason}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            if (request.status == 'PENDING') ...[
              const SizedBox(height: 12),
              Row(
                spacing: 12,
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _showRejectDialog(context),
                      icon: const Icon(Icons.close),
                      label: const Text('Reject'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _approveRequest(context),
                      icon: const Icon(Icons.check),
                      label: const Text('Approve'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
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
        backgroundColor = Colors.green.shade100;
        textColor = Colors.green.shade900;
        break;
      case 'REJECTED':
        backgroundColor = Colors.red.shade100;
        textColor = Colors.red.shade900;
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

  void _approveRequest(BuildContext context) {
    context.read<RequestBloc>().add(ApproveToolRequest(request.requestId));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Request approved successfully')),
    );
  }

  void _showRejectDialog(BuildContext context) {
    final reasonController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Reject Request'),
        content: TextField(
          controller: reasonController,
          decoration: const InputDecoration(
            labelText: 'Rejection Reason',
            hintText: 'Enter reason for rejection',
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (reasonController.text.trim().isNotEmpty) {
                context.read<RequestBloc>().add(
                      RejectToolRequest(
                        request.requestId,
                        reasonController.text.trim(),
                      ),
                    );
                Navigator.pop(dialogContext);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Request rejected')),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Reject'),
          ),
        ],
      ),
    );
  }
}

