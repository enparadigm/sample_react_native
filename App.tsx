import React, { useState } from 'react';
import {
  SafeAreaView,
  ScrollView,
  StatusBar,
  StyleSheet,
  Text,
  TextInput,
  TouchableOpacity,
  View,
  NativeModules
} from 'react-native';

import {
  Colors,
  DebugInstructions,
  Header,
  LearnMoreLinks,
  ReloadInstructions,
} from 'react-native/Libraries/NewAppScreen';
import SharpsellShare from './SharpsellShare';
type SectionProps = {
  title: string;
};

function Section({ children, title }: React.PropsWithChildren<SectionProps>): React.ReactElement {
  return (
    <View style={styles.sectionContainer}>
      <Text style={styles.sectionTitle}>{title}</Text>
      <Text style={styles.sectionDescription}>{children}</Text>
    </View>
  );
}

function App(): React.ReactElement {
  const handleButtonClick = () => {
    // Call the native function when the button is clicked

    SharpsellShare.createEngine();

    SharpsellShare.initialiseEngine({
      company_code: "sharpsell-test-uat", // Company code given to you by sharpsell team
      sharpsell_api_key: "sharpsell-sdk-XOXO-r5CyRDHkGIxw6QViAuGvfbC66xPAlvpm", //  API Key given by the sharpsell team
      user_unique_id: "b1ae9cc0-92ce-11ee-814d-025832576078", // User unique id or user external id which is the id of the user which you are trying to login
      fcm_token: "", // Pass the firebase token
    });
  };

  const isDarkMode = false; // You can use useColorScheme() here if needed

  const [userId, setUserId] = useState('');
  const [apiKey, setApiKey] = useState('');
  const [fcmToken, setFcmToken] = useState('');
  const [companyCode, setCompanyCode] = useState('');

  const handleSubmit = () => {
    console.log('Submitted:', { userId, apiKey, fcmToken, companyCode });
    handleButtonClick();
  };

  const backgroundStyle = {
    backgroundColor: isDarkMode ? Colors.darker : Colors.lighter,
  };

  return (
    <SafeAreaView style={backgroundStyle}>
      <StatusBar barStyle={isDarkMode ? 'light-content' : 'dark-content'} backgroundColor={backgroundStyle.backgroundColor} />
      <ScrollView contentInsetAdjustmentBehavior="automatic" style={backgroundStyle}>
        <Header />
        <View style={{ backgroundColor: isDarkMode ? Colors.black : Colors.white }}>

          <TextInput style={styles.input} onChangeText={setUserId} value={userId} placeholder="Enter User ID" />


          <TextInput style={styles.input} onChangeText={setApiKey} value={apiKey} placeholder="Enter API Key" />


          <TextInput style={styles.input} onChangeText={setFcmToken} value={fcmToken} placeholder="Enter FCM Token" />


          <TextInput style={styles.input} onChangeText={setCompanyCode} value={companyCode} placeholder="Enter Company Code" />

          <TouchableOpacity onPress={handleSubmit}>
            <View style={styles.submitButton}>
              <Text style={styles.submitButtonText}>Submit</Text>
            </View>
          </TouchableOpacity>

        </View>
      </ScrollView>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  // ... (existing styles)

  sectionContainer: {
    marginTop: 32,
    paddingHorizontal: 24,
  },
  sectionTitle: {
    fontSize: 24,
    fontWeight: '600',
  },
  sectionDescription: {
    marginTop: 8,
    fontSize: 18,
    fontWeight: '400',
  },
  input: {
    height: 40,
    borderColor: 'gray',
    borderWidth: 1,
    marginVertical: 8,
    paddingHorizontal: 10,
  },
  submitButton: {
    backgroundColor: '#007BFF',
    padding: 10,
    borderRadius: 5,
    marginVertical: 16,
    alignItems: 'center',
  },
  submitButtonText: {
    color: 'white',
    fontWeight: 'bold',
  },
});

export default App;
