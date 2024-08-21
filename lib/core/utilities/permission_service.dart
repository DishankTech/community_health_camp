import 'package:community_health_app/core/utilities/device_utilities.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  Future<bool> requestPermissions() async {
    var deviceInfo = await DeviceInfoUtil().getDeviceInfo();
    if (deviceInfo['version']['sdkInt'] > 32) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.photos,
        Permission.camera,
      ].request();

      // Check the status of each permission
      if (statuses[Permission.camera]!.isGranted &&
          statuses[Permission.photos]!.isGranted) {
        return true;
      } else {
        print("Permissions denied");
        return false;
      }
    } else {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.storage,
        Permission.camera,
      ].request();

      // Check the status of each permission
      if (statuses[Permission.storage]!.isGranted &&
          statuses[Permission.camera]!.isGranted) {
        return true;
      } else {
        print("Permissions denied");
        return false;
      }
    }
  }

  Future<bool> hasPhonePermission() async {
    return hasPermission(Permission.phone);
  }

  Future<bool> hasPermission(Permission permission) async {
    var permissionStatus = await permission.status;
    return permissionStatus == PermissionStatus.granted;
  }

  Future<bool> hasAllPermission() async {
    var deviceInfo = await DeviceInfoUtil().getDeviceInfo();

    if (deviceInfo['version']['sdkInt'] > 32) {
      var photosStatus = await Permission.photos.status;
      var cameraStatus = await Permission.camera.status;
      if (photosStatus.isGranted && cameraStatus.isGranted) {
        return true;
      } else {
        return false;
      }
    } else {
      var storageStatus = await Permission.storage.status;
      var cameraStatus = await Permission.camera.status;

      if (storageStatus.isGranted && cameraStatus.isGranted) {
        return true;
      } else {
        return false;
      }
    }
  }
}
