import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../themes/app_theme.dart';
import '../widgets/offline_wrapper.dart';


class OfflineScreen extends StatefulWidget {
  final VoidCallback? onRetry;

  const OfflineScreen({super.key, this.onRetry});

  @override
  State<OfflineScreen> createState() => _OfflineScreenState();
}

class _OfflineScreenState extends State<OfflineScreen> {
  bool _isChecking = false;

  Future<void> _checkConnection() async {
    setState(() => _isChecking = true);
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      final results = await Connectivity().checkConnectivity();
      final isOffline = results.isEmpty || results.every((r) => r == ConnectivityResult.none);

      if (!isOffline) {
        OfflineWrapper.forceOfflineNotifier.value = false;
        if (mounted) {
          if (widget.onRetry != null) {
            widget.onRetry!();
          } else if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Still offline. Please check your Wi-Fi or data connection."),
              backgroundColor: AppTheme.errorRed,
            ),
          );
        }
      }
    } catch (e) {
      debugPrint("Error checking connectivity: $e");
    } finally {
      if (mounted) setState(() => _isChecking = false);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: AppTheme.pillBackground,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppTheme.errorRed.withValues(alpha: 0.4), width: 2),
                ),
                child: const Icon(
                  Icons.wifi_off,
                  color: AppTheme.errorRed,
                  size: 50,
                ),
              ),
              const SizedBox(height: 28),
              const Text(
                "No Internet Connection",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "Please check your network settings. AgroBuddy needs an active connection to sync harvest inventory and orders.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: AppTheme.textMuted,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 36),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: _isChecking ? null : _checkConnection,
                  icon: _isChecking
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2, color: AppTheme.textDark),
                        )
                      : const Icon(Icons.refresh, color: AppTheme.textDark),
                  label: const Text(
                    "Try Again",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textDark,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryGold,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
