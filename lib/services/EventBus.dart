import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();

class ProductContentEvent{
  String text;
  ProductContentEvent(String text){
    this.text = text;
  }
}

class UserEvent{
  String text;
  UserEvent(String text){
    this.text = text;
  }
}