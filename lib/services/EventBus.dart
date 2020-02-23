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

class AddressEvent{
  String text;
  AddressEvent(String text){
    this.text = text;
  }
}

class EditAddressEvent{
  String text;
  EditAddressEvent(String text){
    this.text = text;
  }
}

class ChangeAddressEvent{
  String text;
  ChangeAddressEvent(String text){
    this.text = text;
  }
}