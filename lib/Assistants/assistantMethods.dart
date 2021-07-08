import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:rhs_app/Assistants/requestAssistant.dart';
import 'package:rhs_app/DataHandler/appData.dart';
import 'package:rhs_app/Models/address.dart';
import 'package:rhs_app/configMaps.dart';

class AssistantMethods
{
  static Future<String> searchCoordinateAddress(Position position, context) async
  {
    String placeAddress = "";
    String st1, st2, st3, st4;
    String url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude}, ${position.longitude}&key=$mapKey";

    var response = await RequestAssistant.getRequest(url);

    if(response != "failed")
      {
        //placeAddress = response["results"][0]["formatted_address"];
        st1 = response["results"][0]["address_components"][0]["long_name"];
        st2 = response["results"][0]["address_components"][1]["long_name"];
        st3 = response["results"][0]["address_components"][5]["long_name"];
        st4 = response["results"][0]["address_components"][6]["long_name"];
        placeAddress = st1 + "," +st2 + "," + st3 + "," + st4;

        Address userPickUpAddress = Address(longitude: position.longitude, latitude: position.latitude, placeName: placeAddress, placeFormattedAddress: placeAddress, placeId: "asf");
        userPickUpAddress.longitude = position.longitude;
        userPickUpAddress.placeName = placeAddress;

        // ignore: unnecessary_statements
        Provider.of<AppData>(context, listen: false).updatePickUpLocationAddress(userPickUpAddress);
       }


    return placeAddress;
  }
}