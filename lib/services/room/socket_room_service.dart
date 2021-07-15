import 'package:get_it/get_it.dart';

import '../connection_provider.dart';
import 'room_service.dart';

class SocketRoomService implements RoomService {
  final connection = GetIt.I<ConnectionProvider>();

  @override
  void joinRoom({required String name, required String roomCode}) {
    connection.socket.emit('joinRoom', {
      'name': name,
      'roomCode': roomCode,
    });
  }

  @override
  void createRoom({required String name}) {
    connection.socket.emit('createRoom', {
      'name': name,
    });
  }

  @override
  void leaveRoom({required String name, required String roomCode}) {
    connection.socket.emit('leaveRoom', {
      'name': name,
      'roomCode': roomCode,
    });
  }

  @override
  void onRoomJoined(void Function(String) callback) {
    connection.socket.on('roomJoined', (data) => callback(data as String));
  }
}
