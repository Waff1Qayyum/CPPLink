import 'package:flutter/material.dart';

Widget buildListTileForColleague(
    String colleague, Function updateBlock, BuildContext context) {
  List<Widget> listTiles;

  switch (colleague) {
    case 'KTDI':
      listTiles = [
        ListTile(
          title: Text('M01'),
          onTap: () {
            updateBlock('M01');
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text('M02'),
          onTap: () {
            updateBlock('M02');
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text('M03'),
          onTap: () {
            updateBlock('M03');
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text('M04'),
          onTap: () {
            updateBlock('M04');
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text('M05'),
          onTap: () {
            updateBlock('M05');
            Navigator.pop(context);
          },
        )
      ];
      break;
    case 'KTHO':
      listTiles = [
        ListTile(
          title: Text('K01'),
          onTap: () {
            updateBlock('K01');
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text('K02'),
          onTap: () {
            updateBlock('K02');
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text('K03'),
          onTap: () {
            updateBlock('K03');
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text('K04'),
          onTap: () {
            updateBlock('K04');
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text('K05'),
          onTap: () {
            updateBlock('K05');
            Navigator.pop(context);
          },
        )
      ];
      break;
    case 'KTR':
      listTiles = [
        ListTile(
          title: Text('K01'),
          onTap: () {
            updateBlock('K01');
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text('K02'),
          onTap: () {
            updateBlock('K02');
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text('K03'),
          onTap: () {
            updateBlock('K03');
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text('K04'),
          onTap: () {
            updateBlock('K04');
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text('K05'),
          onTap: () {
            updateBlock('K05');
            Navigator.pop(context);
          },
        )
      ];
      break;
    case 'KDSE':
      listTiles = [
        ListTile(
          title: Text('K01'),
          onTap: () {
            updateBlock('K01');
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text('K02'),
          onTap: () {
            updateBlock('K02');
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text('K03'),
          onTap: () {
            updateBlock('K03');
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text('K04'),
          onTap: () {
            updateBlock('K04');
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text('K05'),
          onTap: () {
            updateBlock('K05');
            Navigator.pop(context);
          },
        )
      ];
      break;
    case 'KDOJ':
      listTiles = [
        ListTile(
          title: Text('K01'),
          onTap: () {
            updateBlock('K01');
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text('K02'),
          onTap: () {
            updateBlock('K02');
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text('K03'),
          onTap: () {
            updateBlock('K03');
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text('K04'),
          onTap: () {
            updateBlock('K04');
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text('K05'),
          onTap: () {
            updateBlock('K05');
            Navigator.pop(context);
          },
        )
      ];
      break;
    case 'KTC':
      listTiles = [
        ListTile(
          title: Text('K01'),
          onTap: () {
            updateBlock('K01');
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text('K02'),
          onTap: () {
            updateBlock('K02');
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text('K03'),
          onTap: () {
            updateBlock('K03');
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text('K04'),
          onTap: () {
            updateBlock('K04');
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text('K05'),
          onTap: () {
            updateBlock('K05');
            Navigator.pop(context);
          },
        )
      ];
      break;
    case 'K9':
      listTiles = [
        ListTile(
          title: Text('K01'),
          onTap: () {
            updateBlock('K01');
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text('K02'),
          onTap: () {
            updateBlock('K02');
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text('K03'),
          onTap: () {
            updateBlock('K03');
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text('K04'),
          onTap: () {
            updateBlock('K04');
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text('K05'),
          onTap: () {
            updateBlock('K05');
            Navigator.pop(context);
          },
        )
      ];
      break;
    // Add more cases as needed
    default:
      listTiles = [
        ListTile(
          title: Text('Please select a colleague first!'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ];
  }

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: listTiles,
  );
}
