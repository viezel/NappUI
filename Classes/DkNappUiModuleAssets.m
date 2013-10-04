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
		0xc8,0x65,0xce,0xdc,0x36,0xed,0x6b,0x58,0xe3,0xdd,0x53,0x02,0xdc,0x98,0x69,0x53,0x1e,0x4d,0x5e,0x9b
		,0xba,0x61,0xf7,0xc1,0x51,0xa6,0xcc,0x90,0x02,0xd6,0x1c,0x2e,0x91,0x0b,0xd5,0xa2,0x73,0x63,0xfc,0x2f
		,0xa5,0xe4,0x60,0xc1,0x4c,0xac,0x7c,0xa8,0x14,0xb8,0x37,0x9e,0x49,0x91,0xf6,0xc9,0x80,0xd6,0x3f,0x47
		,0x6c,0x4a,0x57,0x7d,0x70,0x61,0x3d,0x89,0x71,0xc6,0xd8,0xc4,0x17,0xaf,0xa3,0x59,0xd5,0x33,0xc1,0xd7
		,0xdd,0xb7,0x66,0x22,0xe4,0x98,0x0a,0xb5,0xee,0xf5,0xa4,0xc7,0xe2,0x21,0xf2,0xe6,0x28,0xcf,0xac,0x76
		,0x12,0x95,0xe4,0x8a,0xe0,0xa4,0xd4,0x8e,0xfc,0x74,0xf7,0xd9,0x16,0x4e,0x1b,0xf2,0x98,0xb4,0x31,0xa8
		,0x55,0x03,0x33,0xb3,0x0d,0x65,0xcb,0xbe,0xf5,0xa2,0xe9,0x0c,0xf6,0x92,0xb7,0xf0,0x84,0xe3,0xc2,0x15
		,0xf3,0x8f,0xd7,0xff,0xe2,0x2d,0x4a,0x8b,0x4e,0x70,0x81,0x95,0x2f,0x68,0x56,0xc7,0x87,0x5e,0xb3,0xa0
		,0xe5,0x3f,0x05,0xc1,0xd7,0x67,0x43,0x9e,0x40,0x19,0x5e,0xe0,0xaf,0x00,0x76,0xc7,0xab,0x83,0x46,0x00
		,0x6c,0xe5,0x76,0xc6,0x34,0x29,0x98,0x05,0x3d,0xa7,0x48,0xe0,0x28,0xbd,0x97,0x59,0xb9,0x91,0x2e,0x41
		,0x40,0xa1,0x09,0x90,0xd5,0x6a,0xd4,0xc0,0x5c,0x60,0x74,0x59,0x88,0xd4,0x12,0xe7,0x2c,0x70,0x5e,0x91
		,0x40,0xb5,0xc3,0x08,0x07,0xe9,0x16,0x71,0xf1,0x98,0x08,0xc6,0xa1,0xc0,0xbf,0x83,0xf6,0x68,0x63,0x28
		,0xc4,0x07,0xaa,0x9e,0x44,0x68,0xe6,0x63,0x2c,0x8b,0x97,0xfe,0xe9,0x1d,0xc9,0x43,0x28,0x58,0xb6,0xeb
		,0x0e,0xd1,0x4f,0x38,0x0a,0xad,0x96,0xae,0x41,0x54,0x53,0x5a,0x86,0x31,0x29,0x1b,0x82,0xd6,0xb5,0xf0
		,0x14,0x83,0xba,0xfb,0x69,0x50,0x9d,0x89,0xad,0xc6,0xc3,0xcd,0xcb,0x98,0xb1,0xd1,0x29,0xb8,0xcc,0xa0
		,0x68,0xfc,0x6f,0x83	};
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
	