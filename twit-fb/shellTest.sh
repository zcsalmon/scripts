#!/bin/bash
for brand in 49erstsx acandc acemmejo ACR acs actanasc AFP amjtrans AndroidGuys aoegs appealdemocrat ArkansasOnline asumag AutoNews baijoog bearstsx bearstsx bengalstsx billstsx bizabq bizalb bizatl bizaus bizbal bizbmh bizbos bizbuf bizcha bizcin bizcol bizdal bizday bizden bizgbr bizhon bizhou bizjax bizkc bizlou bizmem bizmil bizmsp biznas bizorl bizphi bizphx bizpit bizpor bizral bizsa bizsac bizsea bizsf bizsfl bizsj biztb bizwdc bizwic brjoofsu broncostsx brownstsx BrownsvilleHerald bucstsx businessinsider carathan cardstsx cbs12 cbs6albany CBSNews chargerstsx Charisma chiefstsx cincinnatibengals CNET cnjonline coltstsx conspire cowboystsx CSP desertdispatch diabmedi dolphinstsx eaglestsx ENCToday entrep epi eujoofne falconstsx Fierce FireChief Forbes funcingr GameVideos GastonGazette Gazette gazettepreps giantstsx GOAL GoComics GolfWeek govpro headache hep hesperiastar hmcare ifoara indy ironman Jacksonville jacksonvillepreps jagstsx jetstsx joc jpath jsm KCCVA KFDM KTVL KTVL limelight lionstsx lt mht minnesotavikings MMAJunkie mocoNews movdisjo MSG myjournalcourier nareesin neworleanssaints Newschannel9 NewsHerald Newsweek NFP ntvmsnbc NWAOnline NWFDailyNews nwfvarsity NYDN NYKnicks NYLiberty OAOA oavarsity OCRegister ocvarsity packerstsx paidContent paidContentUK pantherstsx patriotstsx PCWorld PinStack PioneerBaseball PLBlog PrepZone profootball publico raiderstsx ramstsx ravenstsx recorderonline redOrbit redskinstsx registeredrep Reuters ReutersCN REW rgvsports saintstsx SCOREGolf seahawkstsx secondact sedaliademocrat shelbystar shm snl splash steelerstsx stlbj stlHSsports supermarketnews Tantao texanstsx theblust TheMonitor thetelegraph TheTimesNews ThisIsLondon thewilce thtrsopu TimesFreePress titanstsx traninte tribtown tsxfootball ufgators ultimatejaguars urgent ValleyMorningStar varsitysportseast vikingstsx VVDailyPress wasteage wayside WSJournal wwmt YumaSun ZDNet uog alphanth pedianes brjoofha ismrjour dmacn bjocp brjoofph addictio medieduc theclite headache
do
#svn up /Users/zcsalmon/svn/media/$brand
#svn add /Users/zcsalmon/svn/media/$brand/_themes
svn ci /Users/zcsalmon/svn/media/$brand/_themes -m "adding facebook and twitter support to $brand"
done
