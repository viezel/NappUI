/**
 * Module developed by Napp
 * Author Mads Møller
 * www.napp.dk
 */

#import "DkNappUiModuleAssets.h"

extern NSData* filterDataInRange(NSData* thedata, NSRange range);

@implementation DkNappUiModuleAssets

- (NSData*) moduleAsset
{
	static UInt8 data[] = {
		0xe9,0xab,0x93,0xa9,0xba,0x92,0x15,0x6e,0x5f,0x09,0xf5,0xdf,0x9c,0x30,0x47,0x94,0x01,0x18,0x4e,0xd6
		,0x18,0x72,0xc9,0xe5,0x1f,0xc2,0x0b,0x72,0xed,0x45,0x9f,0x04,0xc1,0xb3,0x00,0xbb,0x2b,0xc2,0x26,0x00
		,0x62,0x83,0x43,0x6c,0x4d,0xa5,0xb3,0x5b,0x12,0x1d,0x3e,0xb4,0x29,0x48,0x7a,0xb0,0x95,0xfc,0xfd,0x1a
		,0xb8,0xc2,0x08,0xa1,0xe5,0x4b,0x3f,0x7d,0x1b,0x1b,0x87,0x22,0x2a,0xd3,0x0c,0x96,0xf1,0xd3,0x1c,0xf1
		,0xe9,0xac,0xcc,0xb5,0xde,0x67,0xf0,0xad,0x97,0xfc,0xd1,0xb7,0x6e,0x6a,0x7b,0x8c,0x56,0x32,0x22,0xa0
		,0x84,0xf5,0x70,0x29,0x2e,0x0f,0xcd,0xd0,0xb0,0x40,0x1b,0x25,0x00,0x21,0xd8,0x05,0x8b,0xc9,0xd9,0x37
		,0x6b,0x0a,0xbf,0xc3,0xdf,0x04,0x40,0x13,0x8f,0x92,0x58,0x2c,0xeb,0x66,0x76,0xcb,0x9e,0x70,0x1a,0xd8
		,0xd2,0x02,0xa5,0x78,0xe9,0x79,0x55,0x19,0x37,0x4b,0x69,0x61,0x2f,0x47,0x2c,0x7f,0xfa,0x9a,0xc8,0xa5
		,0x0e,0x0f,0x01,0x0b,0xf5,0xfd,0xe3,0x04,0xcd,0xc3,0xf2,0xaf,0xb2,0x10,0x9a,0x9d,0x4b,0xd1,0xe3,0x74
		,0x6b,0x98,0xb2,0xf2,0x07,0xa2,0xf5,0x85,0xc0,0x34,0x83,0xef,0xe2,0xf5,0xbe,0xd6,0x6b,0x71,0xdb,0x05
		,0xa2,0xa5,0xe9,0x21,0xcb,0x38,0x1c,0x4d,0x7c,0x03,0x85,0xc1,0xc5,0x58,0x90,0x73,0xe8,0xc9,0x0f,0x63
		,0x5c,0x42,0x17,0x74,0x64,0xb5,0x2f,0x0e,0xad,0x41,0x68,0xe0,0x83,0x74,0xaf,0xdd,0x2c,0xe5,0x00,0x66
		,0x8d,0xbb,0x5d,0xa2,0x29,0xf2,0xca,0x91,0x3a,0x5d,0xdf,0x20,0xb7,0x07,0xa7,0xdb,0xd3,0xd1,0x4a,0x1e
		,0x9b,0x72,0x06,0xeb,0x20,0xf3,0xa6,0xdc,0x20,0x5b,0x46,0x00,0x03,0xbb,0xb6,0x19,0x16,0xad,0xdf,0x73
		,0xe5,0x9a,0xf5,0x34,0x2c,0x9d,0x80,0xcd,0x65,0xd6,0xa1,0x10,0xe5,0x88,0x33,0x47,0xe1,0xe0,0x5d,0xbe
		,0x56,0xfd,0xbf,0x3f	};
	static NSRange ranges[] = {
		{0,272}
	};
	static NSDictionary *map = nil;
	if (map == nil) {
		map = [[NSDictionary alloc] initWithObjectsAndKeys:
		[NSNumber numberWithInteger:0], @"dk_napp_ui_js",
		nil];
	}
	return filterDataInRange([NSData dataWithBytesNoCopy:data length:sizeof(data) freeWhenDone:NO], ranges[0]);
}

@end
	