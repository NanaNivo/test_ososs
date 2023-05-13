abstract class HomeEvent {}

class ChangeValue extends HomeEvent
{
  String value;
  ChangeValue({this.value});
}
class ClearValue extends HomeEvent
{

}
class ChangeShape extends HomeEvent
{
  int shape;
  ChangeShape({this.shape});
}