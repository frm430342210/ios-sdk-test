//
//  ViewController.m
//  examples
//
//  Created by dxl on 2018/8/8.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "ViewController.h"
#import <sdk_ios.framework/Headers/sdk_ios.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self generateKeyStore];
}

- (void) generateKeyStore {
    NSString *encPrivateKey = @"privbtGQELqNswoyqgnQ9tcfpkuH8P1Q6quvoybqZ9oTVwWhS6Z2hi1B";
    NSData *password = [@"test1234" dataUsingEncoding : NSUTF8StringEncoding];
    KeyStoreValue *keyStoreValue = [KeyStore generateKeyStore:password :encPrivateKey :2];
    if (![Tools isEmpty : keyStoreValue]) {
        NSLog(@"%@", [keyStoreValue yy_modelToJSONString]);
        NSString *privateKey = [KeyStore decipherKeyStore: keyStoreValue : password];
        NSLog(@"%@", privateKey);
    }
}

- (void) generateMnemonicCode {
//    NSString *randomHex = @"038d7e4dfa3dc89ecccd50fe98b66fb2";
//    NSData *random = [Tools hexStrToData: randomHex];
    //创建比特数组
    NSMutableData *random = [NSMutableData dataWithLength: 16];
    
    //生成随机data
    int status = SecRandomCopyBytes(kSecRandomDefault, random.length, random.mutableBytes);
    if (status == 0) {
        NSArray * words = [Mnemonic generateMnemonicCode: [random copy]];
        NSLog(@"%@", [words componentsJoinedByString:@" "]);
    
        NSMutableArray *hdPaths = [NSMutableArray new];
        [hdPaths addObject: @"M/44H/80H/0H/0/1"];
        [Mnemonic generatePrivateKeys: words : hdPaths];
    }
}

- (void) checkAccountValid {
    AccountService *accountService = [[[SDK sharedInstance] setUrl:@"http://seed1.bumotest.io:26002"] getAccountService];
    AccountCheckValidRequest *request = [AccountCheckValidRequest new];
    [request setAddress:@""];
    AccountCheckValidResponse *response = [accountService checkValid: nil];
    if (response.errorCode == 0) {
        NSLog(@"%@", [response.result yy_modelToJSONString]);
    } else {
        NSLog(@"%@", response.errorDesc);
    }
}

- (void) createNewAccount {
    AccountService *accountService = [[[SDK sharedInstance] setUrl:@"http://seed1.bumotest.io:26002"] getAccountService];
    AccountCreateResponse *response = [accountService create];
    if (response.errorCode == 0) {
        NSLog(@"%@", [response.result yy_modelToJSONString]);
    } else {
        NSLog(@"%@", response.errorDesc);
    }
}

- (void) getAccountInfo {
    NSString *address = @"buQnnUEBREw2hB6pWHGPzwanX7d28xk6KVcp";
    AccountService *accountService = [[[SDK sharedInstance] setUrl:@"http://seed1.bumotest.io:26002"] getAccountService];
    AccountGetInfoRequest *request = [AccountGetInfoRequest new];
    [request setAddress : address];
    AccountGetInfoResponse *response = [accountService getInfo : request];
    if (response.errorCode == 0) {
        NSLog(@"%@", [response.result yy_modelToJSONString]);
    } else {
        NSLog(@"%@", response.errorDesc);
    }
}

- (void) getAccountNonce {
    NSString *address = @"buQnnUEBREw2hB6pWHGPzwanX7d28xk6KVcp";
    AccountService *accountService = [[[SDK sharedInstance] setUrl:@"http://seed1.bumotest.io:26002"] getAccountService];
    AccountGetNonceRequest * request = [AccountGetNonceRequest new];
    [request setAddress : address];
    AccountGetNonceResponse *response = [accountService getNonce : request];
    if (response.errorCode == 0) {
        NSLog(@"%@", [response.result yy_modelToJSONString]);
    } else {
        NSLog(@"%@", response.errorDesc);
    }
}

- (void) getAccountBalance {
    NSString *address = @"buQnnUEBREw2hB6pWHGPzwanX7d28xk6KVcp";
    AccountService *accountService = [[[SDK sharedInstance] setUrl:@"http://seed1.bumotest.io:26002"] getAccountService];
    AccountGetBalanceRequest * request = [AccountGetBalanceRequest new];
    [request setAddress : address];
    AccountGetBalanceResponse *response = [accountService getBalance : request];
    if (response.errorCode == 0) {
        NSLog(@"%@", [response.result yy_modelToJSONString]);
    } else {
        NSLog(@"%@", response.errorDesc);
    }
}

- (void) getAccountAssets {
    NSString *address = @"buQhP94E8FjWDF3zfsxjqVQDeBypvzMrB3y3";
    AccountService *accountService = [[[SDK sharedInstance] setUrl:@"http://seed1.bumotest.io:26002"] getAccountService];
    AccountGetAssetsRequest * request = [AccountGetAssetsRequest new];
    [request setAddress : address];
    AccountGetAssetsResponse *response = [accountService getAssets : request];
    if (response.errorCode == 0) {
        //AssetInfo *assetInfo = [response.result.assets objectAtIndex : 0];
        //NSLog(@"%@, %@", assetInfo.key.code, assetInfo.key.issuer);
        NSLog(@"%@", [response.result yy_modelToJSONString]);
    } else {
        NSLog(@"%@", response.errorDesc);
    }
}

- (void) getAccountMetadata {
    NSString *address = @"buQhP94E8FjWDF3zfsxjqVQDeBypvzMrB3y3";
    AccountService *accountService = [[[SDK sharedInstance] setUrl:@"http://seed1.bumotest.io:26002"] getAccountService];
    AccountGetMetadataRequest * request = [AccountGetMetadataRequest new];
    [request setAddress : address];
    AccountGetMetadataResponse *response = [accountService getMetadata : request];
    if (response.errorCode == 0) {
        //MetadataInfo *metadataInfo = [response.result.metadatas objectAtIndex:0];
        //NSLog(@"%@, %@. %lld", metadataInfo.key, metadataInfo.value, metadataInfo.version);
        NSLog(@"%@", [response.result yy_modelToJSONString]);
    } else {
        NSLog(@"%@", response.errorDesc);
    }
}

- (void) getAssetInfo {
    NSString *address = @"buQhP94E8FjWDF3zfsxjqVQDeBypvzMrB3y3";
    NSString *code = @"TST";
    NSString *issuer = @"buQhP94E8FjWDF3zfsxjqVQDeBypvzMrB3y3";
    AssetGetInfoRequest *request = [AssetGetInfoRequest new];
    [request setAddress : address];
    [request setCode : code];
    [request setIssuer : issuer];
    
    AssetService *assetService = [[[SDK sharedInstance] setUrl:@"http://seed1.bumotest.io:26002"] getAssetService];
    AssetGetInfoResponse *response = [assetService getInfo : request];
    if (response.errorCode == 0) {
        NSLog(@"%@", [response.result yy_modelToJSONString]);
    } else {
        NSLog(@"%@", response.errorDesc);
    }
}

- (void) activateAccount {
    AccountService *accountService = [[[SDK sharedInstance] setUrl:@"http://seed1.bumotest.io:26002"] getAccountService];
    // Create an inactive account
    AccountCreateResponse *activateResponse = [accountService create];
    if (activateResponse.errorCode == 0) {
        NSLog(@"activate response: %@", [activateResponse yy_modelToJSONString]);
    } else {
        NSLog(@"%@", activateResponse.errorDesc);
        return;
    }
    // Build AccountActivateOperation
    NSString *sourceAddress = @"buQnnUEBREw2hB6pWHGPzwanX7d28xk6KVcp";
    NSString *destAddress = activateResponse.result.address;
    int64_t initBalance = 10000000;
    AccountActivateOperation *operation = [AccountActivateOperation new];
    [operation setSourceAddress : sourceAddress];
    [operation setDestAddress : destAddress];
    [operation setInitBalance : initBalance];
    [operation setMetadata : @"activate account"];

    // Build blob, sign and submit transaction
    NSString *privateKey = @"privbyQCRp7DLqKtRFCqKQJr81TurTqG6UKXMMtGAmPG3abcM9XHjWvq";
    int64_t gasPrice = 1000;
    int64_t feeLimit = 1000000;
    int64_t nonce = 68;
    [self buildBlobAndSignAndSubmit:privateKey :sourceAddress :nonce :gasPrice :feeLimit :operation];
}

- (void) setAccountMetadata {
    // Build AccountSetMetadataOperation
    NSString *sourceAddress = @"buQnnUEBREw2hB6pWHGPzwanX7d28xk6KVcp";
    NSString *key = @"setMetadataTest";
    NSString *value = @"201808";
    AccountSetMetadataOperation *operation = [AccountSetMetadataOperation new];
    [operation setSourceAddress : sourceAddress];
    [operation setKey : key];
    [operation setValue : value];
    [operation setMetadata : @"activate account"];
    
    // Build blob, sign and submit transaction
    NSString *privateKey = @"privbyQCRp7DLqKtRFCqKQJr81TurTqG6UKXMMtGAmPG3abcM9XHjWvq";
    int64_t gasPrice = 1000;
    int64_t feeLimit = 1000000;
    int64_t nonce = 73;
    [self buildBlobAndSignAndSubmit:privateKey :sourceAddress :nonce :gasPrice :feeLimit :operation];
}

- (void) setAccountPrivilege {
    // Build AccountSetPrivilegeOperation
    NSString *sourceAddress = @"buQnnUEBREw2hB6pWHGPzwanX7d28xk6KVcp";
    AccountSetPrivilegeOperation *operation = [AccountSetPrivilegeOperation new];
    [operation setSourceAddress : sourceAddress];
    SignerInfo *signer = [SignerInfo new];
    [signer setAddress : @"buQhapCK83xPPdjQeDuBLJtFNvXYZEKb6tKB"];
    [signer setWeight : 2];
    [operation addSigner : signer];
    
    // Build blob, sign and submit transaction
    NSString *privateKey = @"privbyQCRp7DLqKtRFCqKQJr81TurTqG6UKXMMtGAmPG3abcM9XHjWvq";
    int64_t gasPrice = 1000;
    int64_t feeLimit = 1000000;
    int64_t nonce = 74;
    [self buildBlobAndSignAndSubmit:privateKey :sourceAddress :nonce :gasPrice :feeLimit :operation];
}

- (void) issueAsset {
    // Build AssetIssueOperation
    NSString *sourceAddress = @"buQnnUEBREw2hB6pWHGPzwanX7d28xk6KVcp";
    // Asset code
    NSString *code = @"RV";
    // Asset amount
    int64_t amount = 1000000000000;
    AssetIssueOperation *operation = [AssetIssueOperation new];
    [operation setSourceAddress: sourceAddress];
    [operation setCode: code];
    [operation setAmount: amount];
    
    // Build blob, sign and submit transaction
    NSString *privateKey = @"privbyQCRp7DLqKtRFCqKQJr81TurTqG6UKXMMtGAmPG3abcM9XHjWvq";
    int64_t gasPrice = 1000;
    int64_t feeLimit = 1000000;
    int64_t nonce = 75;
    [self buildBlobAndSignAndSubmit:privateKey :sourceAddress :nonce :gasPrice :feeLimit :operation];
}

- (void) sendAsset {
    // Build AssetSendOperation
    NSString *sourceAddress = @"buQnnUEBREw2hB6pWHGPzwanX7d28xk6KVcp";
    // Destination account
    NSString *destAddress = @"buQhapCK83xPPdjQeDuBLJtFNvXYZEKb6tKB";
    // Asset code
    NSString *code = @"TST";
    // Asset issuer
    NSString *issuer = @"buQnnUEBREw2hB6pWHGPzwanX7d28xk6KVcp";
    // Asset amount
    int64_t amount = 100000;
    AssetSendOperation *operation = [AssetSendOperation new];
    [operation setSourceAddress: sourceAddress];
    [operation setDestAddress: destAddress];
    [operation setCode: code];
    [operation setIssuer: issuer];
    [operation setAmount: amount];
    
    // Build blob, sign and submit transaction
    NSString *privateKey = @"privbyQCRp7DLqKtRFCqKQJr81TurTqG6UKXMMtGAmPG3abcM9XHjWvq";
    int64_t gasPrice = 1000;
    int64_t feeLimit = 1000000;
    int64_t nonce = 75;
    [self buildBlobAndSignAndSubmit:privateKey :sourceAddress :nonce :gasPrice :feeLimit :operation];
}

- (void) sendBU {
    // Build BUSendOperation
    NSString *sourceAddress = @"buQnnUEBREw2hB6pWHGPzwanX7d28xk6KVcp";
    // Destination account
    NSString *destAddress = @"buQhapCK83xPPdjQeDuBLJtFNvXYZEKb6tKB";
    // BU amount
    int64_t amount = 1000000;
    BUSendOperation *operation = [BUSendOperation new];
    [operation setSourceAddress: sourceAddress];
    [operation setDestAddress: destAddress];
    [operation setAmount: amount];
    
    // Build blob, sign and submit transaction
    NSString *privateKey = @"privbyQCRp7DLqKtRFCqKQJr81TurTqG6UKXMMtGAmPG3abcM9XHjWvq";
    int64_t gasPrice = 1000;
    int64_t feeLimit = 1000000;
    int64_t nonce = 75;
    [self buildBlobAndSignAndSubmit:privateKey :sourceAddress :nonce :gasPrice :feeLimit :operation];
}

- (void) issueCtp10Token {
    // Build Ctp10TokenIssueOperation
    NSString *sourceAddress = @"buQnnUEBREw2hB6pWHGPzwanX7d28xk6KVcp";
    // The initialization BU of the contract to be created
    int64_t initBalance = [Tools BU2MO: 0.1];
    NSLog(@"%lld", initBalance);
    // The decimals of token amount
    int32_t decimals = 8;
    // The token name
    NSString *name = @"CTP";
    // The token supply
    NSString *supply = @"1000000000000";
    // The token symbol
    NSString *symbol = @"CTP";
    
    Ctp10TokenIssueOperation *operation = [Ctp10TokenIssueOperation new];
    [operation setSourceAddress: sourceAddress];
    [operation setDecimals: decimals];
    [operation setInitBalance: initBalance];
    [operation setName: name];
    [operation setSymbol: symbol];
    [operation setSupply: supply];
    
    // Build blob, sign and submit transaction
    NSString *privateKey = @"privbyQCRp7DLqKtRFCqKQJr81TurTqG6UKXMMtGAmPG3abcM9XHjWvq";
    int64_t gasPrice = 1000;
    int64_t feeLimit = 1000000;
    int64_t nonce = 78;
    [self buildBlobAndSignAndSubmit:privateKey :sourceAddress :nonce :gasPrice :feeLimit :operation];
}

- (void) assignCtp10Token {
    // Build Ctp10TokenAssignOperation
    NSString *sourceAddress = @"buQnnUEBREw2hB6pWHGPzwanX7d28xk6KVcp";
    // The contract account address of contract token code
    NSString *contractAddress = @"buQhdBSkJqERBSsYiUShUZFMZQhXvkdNgnYq";
    // The account to be assign token
    NSString *destAddress = @"buQnnUEBREw2hB6pWHGPzwanX7d28xk6KVcp";
    // The token amoun to be sent
    NSString *amount = @"1000000";
    Ctp10TokenAssignOperation *operation = [Ctp10TokenAssignOperation new];
    [operation setSourceAddress: sourceAddress];
    [operation setContractAddress: contractAddress];
    [operation setDestAddress: destAddress];
    [operation setTokenAmount: amount];
    
    // Build blob, sign and submit transaction
    NSString *privateKey = @"privbyQCRp7DLqKtRFCqKQJr81TurTqG6UKXMMtGAmPG3abcM9XHjWvq";
    int64_t gasPrice = 1000;
    int64_t feeLimit = 1000000;
    int64_t nonce = 78;
    [self buildBlobAndSignAndSubmit:privateKey :sourceAddress :nonce :gasPrice :feeLimit :operation];
}

- (void) transferCtp10Token {
    // Build Ctp10TokenTransferOperation
    NSString *sourceAddress = @"buQnnUEBREw2hB6pWHGPzwanX7d28xk6KVcp";
    // The contract account address of contract token code
    NSString *contractAddress = @"buQhdBSkJqERBSsYiUShUZFMZQhXvkdNgnYq";
    // The account to be assign token
    NSString *destAddress = @"buQhdBSkJqERBSsYiUShUZFMZQhXvkdNgnYq";
    // The token amoun to be sent
    NSString *amount = @"1000000";
    Ctp10TokenTransferOperation *operation = [Ctp10TokenTransferOperation new];
    [operation setSourceAddress: sourceAddress];
    [operation setContractAddress: contractAddress];
    [operation setDestAddress: destAddress];
    [operation setTokenAmount: amount];
    
    // Build blob, sign and submit transaction
    NSString *privateKey = @"privbyQCRp7DLqKtRFCqKQJr81TurTqG6UKXMMtGAmPG3abcM9XHjWvq";
    int64_t gasPrice = 1000;
    int64_t feeLimit = 1000000;
    int64_t nonce = 78;
    [self buildBlobAndSignAndSubmit:privateKey :sourceAddress :nonce :gasPrice :feeLimit :operation];
}

- (void) transferFromCtp10Token {
    // Build Ctp10TokenTransferFromOperation
    NSString *sourceAddress = @"buQnnUEBREw2hB6pWHGPzwanX7d28xk6KVcp";
    // The contract account address of contract token code
    NSString *contractAddress = @"buQhdBSkJqERBSsYiUShUZFMZQhXvkdNgnYq";
    // The account to send token
    NSString *fromAddress = @"buQnnUEBREw2hB6pWHGPzwanX7d28xk6KVcp";
    // The account to be assign token
    NSString *destAddress = @"buQhdBSkJqERBSsYiUShUZFMZQhXvkdNgnYq";
    // The token amoun to be sent
    NSString *amount = @"1000000";
    Ctp10TokenTransferFromOperation *operation = [Ctp10TokenTransferFromOperation new];
    [operation setSourceAddress: sourceAddress];
    [operation setContractAddress: contractAddress];
    [operation setFromAddress: fromAddress];
    [operation setDestAddress: destAddress];
    [operation setTokenAmount: amount];
    
    // Build blob, sign and submit transaction
    NSString *privateKey = @"privbyQCRp7DLqKtRFCqKQJr81TurTqG6UKXMMtGAmPG3abcM9XHjWvq";
    int64_t gasPrice = 1000;
    int64_t feeLimit = 1000000;
    int64_t nonce = 78;
    [self buildBlobAndSignAndSubmit:privateKey :sourceAddress :nonce :gasPrice :feeLimit :operation];
}

- (void) approveCtp10Token {
    // Build Ctp10TokenApproveOperation
    NSString *sourceAddress = @"buQnnUEBREw2hB6pWHGPzwanX7d28xk6KVcp";
    // The contract account address of contract token code
    NSString *contractAddress = @"buQhdBSkJqERBSsYiUShUZFMZQhXvkdNgnYq";
    // The account to be allowed to spend token
    NSString *spender = @"buQnnUEBREw2hB6pWHGPzwanX7d28xk6KVcp";
    // The token amoun to be sent
    NSString *amount = @"1000000";
    Ctp10TokenApproveOperation *operation = [Ctp10TokenApproveOperation new];
    [operation setSourceAddress: sourceAddress];
    [operation setContractAddress: contractAddress];
    [operation setSpender: spender];
    [operation setTokenAmount: amount];
    
    // Build blob, sign and submit transaction
    NSString *privateKey = @"privbyQCRp7DLqKtRFCqKQJr81TurTqG6UKXMMtGAmPG3abcM9XHjWvq";
    int64_t gasPrice = 1000;
    int64_t feeLimit = 1000000;
    int64_t nonce = 78;
    [self buildBlobAndSignAndSubmit:privateKey :sourceAddress :nonce :gasPrice :feeLimit :operation];
}

- (void) changeTokenOwnerCtp10Token {
    // Build Ctp10TokenChangeOwnerOperation
    NSString *sourceAddress = @"buQnnUEBREw2hB6pWHGPzwanX7d28xk6KVcp";
    // The contract account address of contract token code
    NSString *contractAddress = @"buQhdBSkJqERBSsYiUShUZFMZQhXvkdNgnYq";
    // The token owner
    NSString *tokenOwner = @"buQnnUEBREw2hB6pWHGPzwanX7d28xk6KVcp";
    Ctp10TokenChangeOwnerOperation *operation = [Ctp10TokenChangeOwnerOperation new];
    [operation setSourceAddress: sourceAddress];
    [operation setContractAddress: contractAddress];
    [operation setTokenOwner: tokenOwner];
    
    // Build blob, sign and submit transaction
    NSString *privateKey = @"privbyQCRp7DLqKtRFCqKQJr81TurTqG6UKXMMtGAmPG3abcM9XHjWvq";
    int64_t gasPrice = 1000;
    int64_t feeLimit = 1000000;
    int64_t nonce = 78;
    [self buildBlobAndSignAndSubmit:privateKey :sourceAddress :nonce :gasPrice :feeLimit :operation];
}

- (void) checkValidCtp10Token {
    Ctp10TokenCheckValidRequest *request = [Ctp10TokenCheckValidRequest new];
    [request setContractAddress: @"buQhdBSkJqERBSsYiUShUZFMZQhXvkdNgnYq"];
    Ctp10TokenService *service = [[[SDK sharedInstance] setUrl: @"http://seed1.bumotest.io:26002"] getCtp10TokenService];
    Ctp10TokenCheckValidResponse *response = [service checkValid: request];
    if (response.errorCode == 0) {
        NSLog(@"%@", [response.result yy_modelToJSONString]);
    }
    else {
        NSLog(@"error: %@", response.errorDesc);
    }
}

- (void) getCtp10TokenAllowance {
    Ctp10TokenAllowanceRequest *request = [Ctp10TokenAllowanceRequest new];
    [request setContractAddress: @"buQhdBSkJqERBSsYiUShUZFMZQhXvkdNgnYq"];
    [request setTokenOwner: @"buQnnUEBREw2hB6pWHGPzwanX7d28xk6KVcp"];
    [request setSpender: @"buQnnUEBREw2hB6pWHGPzwanX7d28xk6KVcp"];
    
    Ctp10TokenService *service = [[[SDK sharedInstance] setUrl: @"http://seed1.bumotest.io:26002"] getCtp10TokenService];
    Ctp10TokenAllowanceResponse *response = [service allowance: request];
    if (response.errorCode == 0) {
        NSLog(@"%@", [response.result yy_modelToJSONString]);
    }
    else {
        NSLog(@"error: %@", response.errorDesc);
    }
}

- (void) getCtp10TokenInfo {
    Ctp10TokenGetInfoRequest *request = [Ctp10TokenGetInfoRequest new];
    [request setContractAddress: @"buQhdBSkJqERBSsYiUShUZFMZQhXvkdNgnYq"];
    
    Ctp10TokenService *service = [[[SDK sharedInstance] setUrl: @"http://seed1.bumotest.io:26002"] getCtp10TokenService];
    Ctp10TokenGetInfoResponse *response = [service getInfo: request];
    if (response.errorCode == 0) {
        NSLog(@"%@", [response.result yy_modelToJSONString]);
    }
    else {
        NSLog(@"error: %@", response.errorDesc);
    }
}

- (void) getCtp10TokenName {
    Ctp10TokenGetNameRequest *request = [Ctp10TokenGetNameRequest new];
    [request setContractAddress: @"buQhdBSkJqERBSsYiUShUZFMZQhXvkdNgnYq"];
    
    Ctp10TokenService *service = [[[SDK sharedInstance] setUrl: @"http://seed1.bumotest.io:26002"] getCtp10TokenService];
    Ctp10TokenGetNameResponse *response = [service getName: request];
    if (response.errorCode == 0) {
        NSLog(@"%@", [response.result yy_modelToJSONString]);
    }
    else {
        NSLog(@"error: %@", response.errorDesc);
    }
}

- (void) getCtp10TokenSymbol {
    Ctp10TokenGetSymbolRequest *request = [Ctp10TokenGetSymbolRequest new];
    [request setContractAddress: @"buQhdBSkJqERBSsYiUShUZFMZQhXvkdNgnYq"];
    
    Ctp10TokenService *service = [[[SDK sharedInstance] setUrl: @"http://seed1.bumotest.io:26002"] getCtp10TokenService];
    Ctp10TokenGetSymbolResponse *response = [service getSymbol: request];
    if (response.errorCode == 0) {
        NSLog(@"%@", [response.result yy_modelToJSONString]);
    }
    else {
        NSLog(@"error: %@", response.errorDesc);
    }
}

- (void) getCtp10TokenDecimals {
    Ctp10TokenGetDecimalsRequest *request = [Ctp10TokenGetDecimalsRequest new];
    [request setContractAddress: @"buQhdBSkJqERBSsYiUShUZFMZQhXvkdNgnYq"];
    
    Ctp10TokenService *service = [[[SDK sharedInstance] setUrl: @"http://seed1.bumotest.io:26002"] getCtp10TokenService];
    Ctp10TokenGetDecimalsResponse *response = [service getDecimals: request];
    if (response.errorCode == 0) {
        NSLog(@"%@", [response.result yy_modelToJSONString]);
    }
    else {
        NSLog(@"error: %@", response.errorDesc);
    }
}

- (void) getCtp10TokenTotalSupply {
    Ctp10TokenGetTotalSupplyRequest *request = [Ctp10TokenGetTotalSupplyRequest new];
    [request setContractAddress: @"buQhdBSkJqERBSsYiUShUZFMZQhXvkdNgnYq"];
    
    Ctp10TokenService *service = [[[SDK sharedInstance] setUrl: @"http://seed1.bumotest.io:26002"] getCtp10TokenService];
    Ctp10TokenGetTotalSupplyResponse *response = [service getTotalSupply: request];
    if (response.errorCode == 0) {
        NSLog(@"%@", [response.result yy_modelToJSONString]);
    }
    else {
        NSLog(@"error: %@", response.errorDesc);
    }
}

- (void) getCtp10TokenBalance {
    Ctp10TokenGetBalanceRequest *request = [Ctp10TokenGetBalanceRequest new];
    [request setContractAddress: @"buQhdBSkJqERBSsYiUShUZFMZQhXvkdNgnYq"];
    [request setTokenOwner: @"buQnnUEBREw2hB6pWHGPzwanX7d28xk6KVcp"];
    
    Ctp10TokenService *service = [[[SDK sharedInstance] setUrl: @"http://seed1.bumotest.io:26002"] getCtp10TokenService];
    Ctp10TokenGetBalanceResponse *response = [service getBalance: request];
    if (response.errorCode == 0) {
        NSLog(@"%@", [response.result yy_modelToJSONString]);
    }
    else {
        NSLog(@"error: %@", response.errorDesc);
    }
}

- (void) checkContractValid {
    ContractCheckValidRequest *request = [ContractCheckValidRequest new];
    [request setContractAddress: @"buQfnVYgXuMo3rvCEpKA6SfRrDpaz8D8A9Ea"];
    
    ContractService *service = [[[SDK sharedInstance] setUrl: @"http://seed1.bumotest.io:26002"] getContractService];
    ContractCheckValidResponse *response = [service checkValid: request];
    if (response.errorCode == 0) {
        NSLog(@"%@", [response.result yy_modelToJSONString]);
    }
    else {
        NSLog(@"error: %@", response.errorDesc);
    }
}

- (void) getContractInfo {
    ContractGetInfoRequest *request = [ContractGetInfoRequest new];
    [request setContractAddress: @"buQfnVYgXuMo3rvCEpKA6SfRrDpaz8D8A9Ea"];
    
    ContractService *service = [[[SDK sharedInstance] setUrl: @"http://seed1.bumotest.io:26002"] getContractService];
    ContractGetInfoResponse *response = [service getInfo: request];
    if (response.errorCode == 0) {
        NSLog(@"%@", [response.result yy_modelToJSONString]);
    }
    else {
        NSLog(@"error: %@", response.errorDesc);
    }
}

- (void) getContractAddress {
    ContractGetAddressRequest *request = [ContractGetAddressRequest new];
    [request setHash: @"44246c5ba1b8b835a5cbc29bdc9454cdb9a9d049870e41227f2dcfbcf7a07689"];
    
    ContractService *service = [[[SDK sharedInstance] setUrl: @"http://seed1.bumotest.io:26002"] getContractService];
    ContractGetAddressResponse *response = [service getAddress: request];
    if (response.errorCode == 0) {
        NSLog(@"%@", [response.result yy_modelToJSONString]);
    }
    else {
        NSLog(@"error: %@", response.errorDesc);
    }
}

- (void) callContract {
    ContractCallRequest *request = [ContractCallRequest new];
    [request setCode : @"\"use strict\";log(undefined);function query() { getBalance(thisAddress); }"];
    [request setFeeLimit : 1000000000];
    [request setOptType : 2];
    
    ContractService *service = [[[SDK sharedInstance] setUrl: @"http://seed1.bumotest.io:26002"] getContractService];
    ContractCallResponse *response = [service call : request];
    if (response.errorCode == 0) {
        NSLog(@"%@", [response.result yy_modelToJSONString]);
    }
    else {
        NSLog(@"error: %@", response.errorDesc);
    }
}

- (void) createContract {
    // Build ContractCreateOperation
    NSString *sourceAddress = @"buQnnUEBREw2hB6pWHGPzwanX7d28xk6KVcp";
    // Contract account initialization BU，the unit is MO，and 1 BU = 10^8 MO
    int64_t initBalance = [Tools BU2MO: 0.01];
    // Contract code
    NSString *payload = @"\n          \"use strict\";\n          function init(bar)\n          {\n            /*init whatever you want*/\n            return;\n          }\n          \n          function main(input)\n          {\n            let para = JSON.parse(input);\n            if (para.do_foo)\n            {\n              let x = {\n                \'hello\' : \'world\'\n              };\n            }\n          }\n          \n          function query(input)\n          { \n            return input;\n          }\n        ";
    // The contract account address of contract token code
    NSString *initInput = @"";
    ContractCreateOperation *operation = [ContractCreateOperation new];
    [operation setSourceAddress: sourceAddress];
    [operation setInitBalance: initBalance];
    [operation setPayload: payload];
    [operation setInitInput: initInput];
    [operation setMetadata: @"create contract"];
    
    // Build blob, sign and submit transaction
    NSString *privateKey = @"privbyQCRp7DLqKtRFCqKQJr81TurTqG6UKXMMtGAmPG3abcM9XHjWvq";
    int64_t gasPrice = 1000;
    int64_t feeLimit = 1000000;
    int64_t nonce = 78;
    [self buildBlobAndSignAndSubmit:privateKey :sourceAddress :nonce :gasPrice :feeLimit :operation];
}

- (void) invokeContractByAsset {
    // Build ContractCreateOperation
    NSString *sourceAddress = @"buQnnUEBREw2hB6pWHGPzwanX7d28xk6KVcp";
    // The account to receive the assets
    NSString *contractAddress = @"buQd7e8E5XMa7Yg6FJe4BeLWfqpGmurxzZ5F";
    // The asset code to be sent
    NSString *assetCode = @"TST";
    // The account address to issue asset
    NSString *assetIssuer = @"buQnnUEBREw2hB6pWHGPzwanX7d28xk6KVcp";
    // 0 means that the contract is only triggered
    int64_t amount = 0;
    // Contract main function entry
    NSString *input = @"";
    ContractInvokeByAssetOperation *operation = [ContractInvokeByAssetOperation new];
    [operation setSourceAddress: sourceAddress];
    [operation setContractAddress: contractAddress];
    [operation setCode: assetCode];
    [operation setIssuer: assetIssuer];
    [operation setAmount: amount];
    [operation setInput: input];
    [operation setMetadata: @"send asset and invoke contract"];
    
    // Build blob, sign and submit transaction
    NSString *privateKey = @"privbyQCRp7DLqKtRFCqKQJr81TurTqG6UKXMMtGAmPG3abcM9XHjWvq";
    int64_t gasPrice = 1000;
    int64_t feeLimit = 1000000;
    int64_t nonce = 78;
    [self buildBlobAndSignAndSubmit:privateKey :sourceAddress :nonce :gasPrice :feeLimit :operation];
}

- (void) invokeContractByBU {
    // Build ContractCreateOperation
    NSString *sourceAddress = @"buQnnUEBREw2hB6pWHGPzwanX7d28xk6KVcp";
    // The account to receive the assets
    NSString *contractAddress = @"buQd7e8E5XMa7Yg6FJe4BeLWfqpGmurxzZ5F";
    // 0 means that the contract is only triggered
    int64_t amount = 0;
    // Contract main function entry
    NSString *input = @"";
    ContractInvokeByBUOperation *operation = [ContractInvokeByBUOperation new];
    [operation setSourceAddress: sourceAddress];
    [operation setContractAddress: contractAddress];
    [operation setAmount: amount];
    [operation setInput: input];
    [operation setMetadata: @"send bu and invoke contract"];
    
    // Build blob, sign and submit transaction
    NSString *privateKey = @"privbyQCRp7DLqKtRFCqKQJr81TurTqG6UKXMMtGAmPG3abcM9XHjWvq";
    int64_t gasPrice = 1000;
    int64_t feeLimit = 1000000;
    int64_t nonce = 78;
    [self buildBlobAndSignAndSubmit:privateKey :sourceAddress :nonce :gasPrice :feeLimit :operation];
}

- (void) getTransactionByHash {
    TransactionGetInfoRequest *request = [TransactionGetInfoRequest new];
    [request setHash: @"389d53e55929c997d22f25d3757b088e2e869403ac0f2d13712ba877762b3d45"];
    
    TransactionService *service = [[[SDK sharedInstance] setUrl: @"http://seed1.bumotest.io:26002"] getTransactionService];
    TransactionGetInfoResponse *response = [service getInfo: request];
    if (response.errorCode == 0) {
        NSLog(@"%@", [response.result yy_modelToJSONString]);
    }
    else {
        NSLog(@"error: %@", response.errorDesc);
    }
}

- (void) checkBlockStatus {
    BlockService *service = [[[SDK sharedInstance] setUrl: @"http://seed1.bumotest.io:26002"] getBlockService];
    BlockCheckStatusResponse *response = [service checkStatus];
    if (response.errorCode == 0) {
        NSLog(@"%@", [response.result yy_modelToJSONString]);
    }
    else {
        NSLog(@"error: %@", response.errorDesc);
    }
}

- (void) getTransactionsByBlockNumber {
    BlockGetTransactionsRequest *request = [BlockGetTransactionsRequest new];
    [request setBlockNumber: 617247];
    
    BlockService *service = [[[SDK sharedInstance] setUrl: @"http://seed1.bumotest.io:26002"] getBlockService];
    BlockGetTransactionsResponse *response = [service getTransactions: request];
    if (response.errorCode == 0) {
        NSLog(@"%@", [response.result yy_modelToJSONString]);
    }
    else {
        NSLog(@"error: %@", response.errorDesc);
    }
}

- (void) getLatestBlockNumber {
    BlockService *service = [[[SDK sharedInstance] setUrl: @"http://seed1.bumotest.io:26002"] getBlockService];
    BlockGetNumberResponse *response = [service getNumber];
    if (response.errorCode == 0) {
        NSLog(@"%@", [response.result yy_modelToJSONString]);
    }
    else {
        NSLog(@"error: %@", response.errorDesc);
    }
}

- (void) getBlockInfo {
    BlockGetInfoRequest *request = [BlockGetInfoRequest new];
    [request setBlockNumber: 617247];
    
    BlockService *service = [[[SDK sharedInstance] setUrl: @"http://seed1.bumotest.io:26002"] getBlockService];
    BlockGetInfoResponse *response = [service getInfo: request];
    if (response.errorCode == 0) {
        NSLog(@"%@", [response.result yy_modelToJSONString]);
    }
    else {
        NSLog(@"error: %@", response.errorDesc);
    }
}

- (void) getBlockLatestInfo {
    BlockService *service = [[[SDK sharedInstance] setUrl: @"http://seed1.bumotest.io:26002"] getBlockService];
    BlockGetLatestInfoResponse *response = [service getLatestInfo];
    if (response.errorCode == 0) {
        NSLog(@"%@", [response.result yy_modelToJSONString]);
    }
    else {
        NSLog(@"error: %@", response.errorDesc);
    }
}

- (void) getBlockValidators {
    BlockGetValidatorsRequest *request = [BlockGetValidatorsRequest new];
    [request setBlockNumber: 617247];
    
    BlockService *service = [[[SDK sharedInstance] setUrl: @"http://seed1.bumotest.io:26002"] getBlockService];
    BlockGetValidatorsResponse *response = [service getValidators: request];
    if (response.errorCode == 0) {
        NSLog(@"%@", [response.result yy_modelToJSONString]);
    }
    else {
        NSLog(@"error: %@", response.errorDesc);
    }
}

- (void) getLatestBlockValidators {
    BlockService *service = [[[SDK sharedInstance] setUrl: @"http://seed1.bumotest.io:26002"] getBlockService];
    BlockGetLatestValidatorsResponse *response = [service getLatestValidators];
    if (response.errorCode == 0) {
        NSLog(@"%@", [response.result yy_modelToJSONString]);
    }
    else {
        NSLog(@"error: %@", response.errorDesc);
    }
}

- (void) getBlockReward {
    BlockGetRewardRequest *request = [BlockGetRewardRequest new];
    [request setBlockNumber: 617247];
    
    BlockService *service = [[[SDK sharedInstance] setUrl: @"http://seed1.bumotest.io:26002"] getBlockService];
    BlockGetRewardResponse *response = [service getReward: request];
    if (response.errorCode == 0) {
        NSLog(@"%@", [response.result yy_modelToJSONString]);
    }
    else {
        NSLog(@"error: %@", response.errorDesc);
    }
}

- (void) getLatestBlockReward {
    BlockService *service = [[[SDK sharedInstance] setUrl: @"http://seed1.bumotest.io:26002"] getBlockService];
    BlockGetLatestRewardResponse *response = [service getLatestReward];
    if (response.errorCode == 0) {
        NSLog(@"%@", [response.result yy_modelToJSONString]);
    }
    else {
        NSLog(@"error: %@", response.errorDesc);
    }
}

- (void) getBlockFees {
    BlockGetFeesRequest *request = [BlockGetFeesRequest new];
    [request setBlockNumber: 617247];
    
    BlockService *service = [[[SDK sharedInstance] setUrl: @"http://seed1.bumotest.io:26002"] getBlockService];
    BlockGetFeesResponse *response = [service getFees: request];
    if (response.errorCode == 0) {
        NSLog(@"%@", [response.result yy_modelToJSONString]);
    }
    else {
        NSLog(@"error: %@", response.errorDesc);
    }
}

- (void) getBlockLatestFees {
    BlockService *service = [[[SDK sharedInstance] setUrl: @"http://seed1.bumotest.io:26002"] getBlockService];
    BlockGetLatestFeesResponse *response = [service getLatestFees];
    if (response.errorCode == 0) {
        NSLog(@"%@", [response.result yy_modelToJSONString]);
    }
    else {
        NSLog(@"error: %@", response.errorDesc);
    }
}

- (void) buildBlobAndSignAndSubmit : (NSString *) privateKey : (NSString *) sourceAddress : (int64_t) nonce : (int64_t) gasPrice : (int64_t) feeLimit : (BaseOperation *)operation {
    TransactionBuildBlobRequest *buildBlobRequest = [TransactionBuildBlobRequest new];
    [buildBlobRequest setSourceAddress : sourceAddress];
    [buildBlobRequest setNonce : nonce];
    [buildBlobRequest setGasPrice : gasPrice];
    [buildBlobRequest setFeeLimit : feeLimit];
    [buildBlobRequest addOperation : operation];
    
    TransactionService *transactionServer = [[[SDK sharedInstance] setUrl:@"http://seed1.bumotest.io:26002"] getTransactionService];
    TransactionBuildBlobResponse *buildBlobResponse = [transactionServer buildBlob : buildBlobRequest];
    if (buildBlobResponse.errorCode == 0) {
        NSLog(@"blob: %@, hash: %@", buildBlobResponse.result.transactionBlob, buildBlobResponse.result.transactionHash);
    } else {
        NSLog(@"error: %@", buildBlobResponse.errorDesc);
        return;
    }
    
    TransactionSignRequest *signRequest = [TransactionSignRequest new];
    [signRequest setBlob : buildBlobResponse.result.transactionBlob];
    [signRequest addPrivateKey : privateKey];
    TransactionSignResponse * signResponse = [transactionServer sign : signRequest];
    if (signResponse.errorCode == 0) {
        NSLog(@"sign response: %@", [signResponse yy_modelToJSONString]);
    } else {
        NSLog(@"error: %@", signResponse.errorDesc);
        return;
    }
    
    TransactionSubmitRequest *submitRequest = [TransactionSubmitRequest new];
    [submitRequest setTransactionBlob : buildBlobResponse.result.transactionBlob];
    [submitRequest setSignatures : [signResponse.result.signatures copy]];
    TransactionSubmitResponse *submitResponse = [transactionServer submit : submitRequest];
    if (submitResponse.errorCode == 0) {
        NSLog(@"submit response: %@", [submitResponse yy_modelToJSONString]);
    } else {
        NSLog(@"error: %@", submitResponse.errorDesc);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
