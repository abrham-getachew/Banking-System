import 'dart:async';
import 'package:chronos/Features/complete_signup/presentation/pages/page_7.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ConfirmDeliveryAddressPage extends StatefulWidget {
  @override
  _ConfirmDeliveryAddressPageState createState() => _ConfirmDeliveryAddressPageState();
}

class _ConfirmDeliveryAddressPageState extends State<ConfirmDeliveryAddressPage> {
  Position? _currentPosition;
  String? _currentAddress;
  String? _errorMessage;
  GoogleMapController? _mapController;

  @override
  void initState() {
    super.initState();
    _initLocationFlow();
  }

  Future<void> _initLocationFlow() async {
    try {
      if (!await Geolocator.isLocationServiceEnabled()) {
        setState(() => _errorMessage = 'Please enable location services.');
        return;
      }

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
        setState(() => _errorMessage = 'Location permission denied.');
        return;
      }

      Position pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      ).timeout(Duration(seconds: 10), onTimeout: () {
        throw TimeoutException('Timeout getting location');
      });

      List<Placemark> placemarks = await placemarkFromCoordinates(
        pos.latitude,
        pos.longitude,
      ).timeout(Duration(seconds: 10), onTimeout: () {
        throw TimeoutException('Timeout reverse geocoding');
      });

      final place = placemarks.first;
      final formatted = [
        if (place.street?.isNotEmpty ?? false) place.street,
        place.subLocality,
        place.locality,
        place.administrativeArea,
        place.country,
        place.postalCode
      ].where((s) => s?.isNotEmpty ?? false).join(', ');

      setState(() {
        _currentPosition = pos;
        _currentAddress = formatted;
        _errorMessage = null;
      });

      _mapController?.animateCamera(
        CameraUpdate.newLatLng(LatLng(pos.latitude, pos.longitude)),
      );
    } catch (e) {
      setState(() => _errorMessage = e.toString());
    }
  }

  void _onMapCreated(GoogleMapController ctrl) {
    _mapController = ctrl;
    if (_currentPosition != null) {
      ctrl.moveCamera(
        CameraUpdate.newLatLng(LatLng(_currentPosition!.latitude, _currentPosition!.longitude)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirm Delivery Address', style: TextStyle(color: Colors.black, fontSize: 20)),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300, width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _errorMessage ?? (_currentAddress ?? 'Locating your address…'),
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    TextButton(
                      onPressed: () {/* navigate to edit */},
                      child: Text('Edit', style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor)),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: _errorMessage != null
                  ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(_errorMessage!),
                    SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: _initLocationFlow,
                      child: Text('Retry'),
                    ),
                  ],
                ),
              )
                  : (_currentPosition == null
                  ? Center(child: CircularProgressIndicator())
                  : GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
                  zoom: 15,
                ),
                markers: {
                  Marker(
                    markerId: MarkerId('current'),
                    position: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
                  ),
                },
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
              )),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    if (_currentAddress != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TickPayScreen(),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Confirm delivery address',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

